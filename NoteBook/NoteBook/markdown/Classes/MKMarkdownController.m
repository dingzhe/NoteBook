//
// Created by 史伟夫 on 8/11/15.
// Copyright (c) 2015 shiweifu. All rights reserved.
//

#import "MKMarkdownController.h"
#import "MKTextView.h"
#import "MKPreviewController.h"

@interface MKMarkdownController() <UITextViewDelegate>

@property (nonatomic, strong) MKTextView *textView;
@property (nonatomic, strong) NSString *editType;
@property (nonatomic, strong) RACCommand *addweeklyCommand;
@property (nonatomic, strong) RACCommand *updateWeeklyCommand;
@property (nonatomic, strong) SWGWeekly *model;
@end


@implementation MKMarkdownController
{

}

- (instancetype)initWithAddNote
{
    self = [super init];
    if (self) {
        [self initCommand];
        _editType = @"addnote";
    }
    return self;
}
- (instancetype)initWithModel:(SWGWeekly *)model
{
    self = [super init];
    if (self) {
        _model = model;
        [self initUpdateCommand];
        _editType = @"editnote";
    }
    return self;
}

- (void)initCommand{
    @weakify(self)
    _addweeklyCommand = [NoteBookWeeklyService.service addWeeklyCommandEnable:nil];
    
    [_addweeklyCommand.responses subscribeNext:^(SWGAddWeeklyResponses *response) {
        @strongify(self)
//        [self.showHUDSignal sendNext:@"保存成功"];
        NSLog(@"%@",response);
        
//        [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
    }];
    [_addweeklyCommand.errors subscribeNext:^(NSError *error) {
        NSLog(@"%@",error);
        
        //            DDLogError(@"Error while update base:%@", error);
    }];
}
- (void)initUpdateCommand{
    @weakify(self)
    _updateWeeklyCommand = [NoteBookWeeklyService.service updateWeeklyCommandEnable:nil];
    
    [_updateWeeklyCommand.responses subscribeNext:^(SWGAddWeeklyResponses *response) {
        @strongify(self)
        //        [self.showHUDSignal sendNext:@"保存成功"];
        NSLog(@"%@",response);
        
        //        [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
    }];
    [_updateWeeklyCommand.errors subscribeNext:^(NSError *error) {
        NSLog(@"%@",error);
        
        //            DDLogError(@"Error while update base:%@", error);
    }];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.textView = [[MKTextView alloc] initWithFrame:self.view.bounds];
  [self.view addSubview:_textView];
  if(!self.title)
  {
    self.title = @"编辑";
  }

  self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *openPreview = [[UIBarButtonItem alloc] initWithTitle:@"预览"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(onPreview:)];
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onPreview:)];
    UIBarButtonItem *updateBtn = [[UIBarButtonItem alloc] initWithTitle:@"同步"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(onPreview:)];
    
    
    self.navigationItem.rightBarButtonItems = @[openPreview,saveBtn,updateBtn];
//  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览"
//                                                                            style:UIBarButtonItemStylePlain
//                                                                           target:self
//                                                                           action:@selector(onPreview:)];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(closeView)];
    
  self.textView.delegate = self;
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWasShown:)
                                               name:UIKeyboardDidShowNotification
                                             object:nil];

  [self.textView becomeFirstResponder];

  self.textView.text = self.defaultMarkdownText;
}
- (void)viewWillDisappear:(BOOL)animated{
    if ([_editType isEqualToString:@"addnote"]) {
        [self addWeekly];
    }else if ([_editType isEqualToString:@"editnote"]){
        [self updateWeekly];
    }
}
- (void)addWeekly{
    SWGAddWeeklyRequest * request = [[SWGAddWeeklyRequest alloc] init];
    request.uid = @"9";
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd[hh:mm:ss]"];
    date = [formatter stringFromDate:[NSDate date]];
    request.title = date;
    request.content = self.textView.text;
    request.dateline = date;
    
    //    request.dateline =
    [_addweeklyCommand execute:request];
}

- (void)updateWeekly{
    SWGUpdateWeeklyRequest * request = [[SWGUpdateWeeklyRequest alloc] init];
    request.uid = _model.uid;
    request.weeklyid = _model.weeklyid;
    request.title = _model.title;
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd[hh:mm:ss]"];
    date = [formatter stringFromDate:[NSDate date]];
//    request.title = date;
    request.content = self.textView.text;
    request.dateline = date;
    
    //    request.dateline =
    [_updateWeeklyCommand execute:request];
}
- (void)closeView{
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];

}
- (void)onPreview:(id)onPreview
{
  MKPreviewController *previewController = MKPreviewController.new;
  previewController.bodyMarkdown = self.textView.text;
  previewController.onComplete   = self.onComplete;
  [self.navigationController pushViewController:previewController
                                       animated:YES];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
  CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

  float height = [self.view bounds].size.height - self.textView.frame.origin.y - keyboardSize.height;// - self.toolBar.frameSizeHeight;
  self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, CGRectGetWidth([[UIApplication sharedApplication] keyWindow].frame), height);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
  [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
  [textView resignFirstResponder];
}


@end