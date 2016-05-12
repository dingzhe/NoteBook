//
// Created by 史伟夫 on 8/11/15.
// Copyright (c) 2015 shiweifu. All rights reserved.
//

#import "MKPreviewController.h"
#import "MMMarkdown.h"

@interface MKPreviewController()

@property (nonatomic, strong) NSString *html;

@end


@implementation MKPreviewController
{
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  if(!self.title)
  {
      if (_type == MKPreviewControllerBlog) {
          self.title = @"博客";
      }else if (_type == MKPreviewControllerNote){
          self.title = @"笔记";
      }else {
          self.title = @"预览";
      }
    
  }
    
    
    if (_type == MKPreviewControllerBlog) {
        
        [self setBlogType];
    }else if (_type == MKPreviewControllerNote){
        
        [self setNoteType];
    }else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(onSubmit:)];
    }
  UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:webView];
  self.html = [MMMarkdown HTMLStringWithMarkdown:self.bodyMarkdown
                                      extensions:MMMarkdownExtensionsGitHubFlavored
                                           error:nil];
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"markdown" ofType:@"html"];
  NSString *content  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
  NSString *s = [self replaceString:content withDict:@{@"content": self.html}];

  NSString *path = [[NSBundle mainBundle] resourcePath];
  [webView loadHTMLString:s baseURL:nil];


  


}

- (void)setBlogType{
    UIBarButtonItem *favorites = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleDone target:self action:@selector(onSubmit1:)];
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleDone target:self action:@selector(onSubmit1:)];
    self.navigationItem.rightBarButtonItems = @[share,favorites];
}

- (void)setNoteType{
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(onSubmit1:)];
    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(onSubmit1:)];
    self.navigationItem.rightBarButtonItems = @[setting,edit];
}
- (void)openNoteSettingView{
    

}

- (void)onSubmit:(id)sender
{
  if(self.onComplete)
  {
    self.onComplete(self);
  }
}
- (void)onSubmit1:(UIBarButtonItem *)sender
{
    if(self.onclickBarBtn)
    {
        self.onclickBarBtn(sender);
    }
}
- (NSString *)bodyMarkdown
{
  if(!_bodyMarkdown)
  {
    return @"";
  }
  return _bodyMarkdown;
}

#pragma mark - Utils

- (NSString *)replaceString:(NSString *)s withDict:(NSDictionary *)dictionary
{
  for (int i = 0; i < dictionary.allKeys.count; ++i)
  {
    NSString *k = dictionary.allKeys[i];
    NSString *v = dictionary[k];
    k = [NSString stringWithFormat:@"###%@###", k];
    s = [s stringByReplacingOccurrencesOfString:k withString:v];
  }

  return s;
}

@end
