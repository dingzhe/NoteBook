//
//  WebViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "WebViewController.h"
#import "Masonry.h"
#import "UIView+HUD.h"
//#import "URLHandlerManager+DzNote.h"
//#import "WebViewActionModel.h"
#import "UIView+HUD.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,assign) BOOL titleSetted;
@property (nonatomic,strong) RACCommand *setMassageReadCommand;
@end


@implementation WebViewController
- (void) _updateBarButtonType:(WebViewBarButtonType) type{
    
    UIBarButtonItem *item = nil;
    if (WebViewBarButtonTypeLoading == type) {
        UIActivityIndicatorView *indicator = \
        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        indicator.hidesWhenStopped = YES;
        [indicator startAnimating];
        
        item = [[UIBarButtonItem alloc] initWithCustomView:indicator];
    }
    else if (WebViewBarButtonTypeFavPosition == type) {
        item = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(favPosition)];
    }
    
    self.navigationItem.rightBarButtonItem = item;
}

+ (instancetype) controllerWithURL:(NSURL *)url title:(NSString *)title {
    return [[self alloc] initWithURL:url title:title];
}

- (instancetype) initWithURL:(NSURL *)url title:(NSString *)title {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _url = url;
        
        self.title = title;
        _titleSetted = [title isNotEmpty];
        _finishButtonType = WebViewBarButtonTypeNone;
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _webView.backgroundColor = UIColor.clearColor;
    _webView.scrollView.backgroundColor = UIColor.clearColor;
    _webView.scrollView.clipsToBounds = NO;
    _webView.scalesPageToFit = YES;
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    @weakify(self)
//    [[WebViewActionModel.model.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString* message) {
//        @strongify(self)
//        [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
//    }];
//    [[WebViewActionModel.model.refreshSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//        @strongify(self)
//        [self refreshWebView];
//    }];
//    
//    [self.view bindHUDWithExecuting:WebViewActionModel.model.hudExecuting];
    
    [self refreshWebView];
}

- (void)refreshWebView {
//    NSString *uid = [_url.queryDict objectForKey:@"uid"];
//    if (uid!=nil && uid.length==0 && UserModel.currentUser.uid!=nil) {
//        NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:_url.queryDict];
//        [paramDic setObject:UserModel.currentUser.uid forKey:@"uid"];
//        self.url = [NSURL URLWithString:[SWGApi signedH5UrlWithParamDic:paramDic]];
//    }
    NSURLRequest *request =[NSURLRequest requestWithURL:_url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)favPosition {
//    NSString *positionId = [_url.queryDict objectForKey:@"job_id"];
//    if (positionId!=nil) {
//        [WebViewActionModel.model favPositionWithPositionId:positionId];
//    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.scheme isEqualToString:@"vision"]) {
        
//        if (VisionObjectTypeRequireJob == request.URL.objectType) {
//            [WebViewActionModel.model requirePositionWithPositionId:[request.URL.paramDic objectForKey:@"jobid"]];
//        }else{
//            [URLHandlerManager.manager handleURL:request.URL sourceApplication:nil annotation:@{URLHandlerViewPresentingStyleKey: URLHandlerViewPresentingStylePush}];
//        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    DDLogDebug(@"[WebViewController] webViewDidStartLoad:%@", webView.request);
    
    [self _updateBarButtonType:WebViewBarButtonTypeLoading];
    
    [self.view showHUDWithoutText];
    
    if (!_titleSetted) {
        self.title = @"加载中...";
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    DDLogDebug(@"[WebViewController] webViewDidFinishLoad:%@", webView.request);
    [self _updateBarButtonType:_finishButtonType];
    [self.view dismissHUD];
    
    if (!_titleSetted) {
        self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        _titleSetted = YES;
    }
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    DDLogDebug(@"[WebViewController] webViewdidFailLoadWithError:%@ error:%@", webView.request, error);
    
    [self _updateBarButtonType:WebViewBarButtonTypeNone];
    
    [self.view showHUDWithText:@"页面加载出错"
                    detailText:nil
                   autoDismiss:YES];
    
}

@end
