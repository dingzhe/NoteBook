//
//  TextViewViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "TextViewViewController.h"
#import "UIImage+DzNote.h"

@interface TextViewViewController ()

@property(nonatomic,strong) UITextView *editTextField;
@property(nonatomic,strong) UIButton *navSaveBtn;
@property(nonatomic,strong) UIButton *saveBtn;

@end

@implementation TextViewViewController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _completeSignal = [RACSubject subject];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navSaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navSaveBtn setBackgroundColor:[UIColor clearColor]];
    [_navSaveBtn setFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width - 44, 0, 44, 44)];
    [_navSaveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_navSaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navSaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_navSaveBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    self.editTextField = [[UITextView alloc]initWithFrame:CGRectMake(24, 20,self.view.frame.size.width-48, 60)];
    _editTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _editTextField.layer.borderWidth = 1.f;
    _editTextField.text = ((_text == nil|| [_text isEqualToString:@"未填写"]||[_text isEqualToString:@"必填"])?@"":_text);
    [self.view addSubview:_editTextField];
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_saveBtn setFrame:CGRectMake(24, _editTextField.frame.origin.y+_editTextField.frame.size.height+10,self.view.frame.size.width-48, 33)];
    [_saveBtn setBackgroundImage:[UIImage greenBtnNormalImage] forState:UIControlStateNormal];
    [_saveBtn setBackgroundImage:[UIImage greenBtnDisableImage] forState:UIControlStateDisabled];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn.titleLabel setFont:[UIFont largeFont]];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_saveBtn];
    
    @weakify(self)
    RACSignal *enabeld = \
    [RACSignal combineLatest:@[self.editTextField.rac_textSignal]
                      reduce:^(NSString *text){
                          return @(text.length > 0);
                      }];
    
    self.saveBtn.rac_command = \
    [RACCommand commandWithEnabled:enabeld
                             block:^(id input) {
                                 @strongify(self)
                                 [self.view endEditing:YES];
                                 [self.completeSignal sendNext:self.editTextField.text];
                             }];
    self.navSaveBtn.rac_command = \
    [RACCommand commandWithEnabled:enabeld
                             block:^(id input) {
                                 @strongify(self)
                                 [self.view endEditing:YES];
                                 [self.completeSignal sendNext:self.editTextField.text];
                             }];
}




@end
