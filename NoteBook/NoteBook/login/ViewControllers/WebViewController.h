//
//  WebViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseViewController.h"

typedef NS_ENUM(NSInteger, WebViewBarButtonType)  {
    WebViewBarButtonTypeNone,
    WebViewBarButtonTypeLoading,
    WebViewBarButtonTypeFavPosition
};

@interface WebViewController : NBBaseViewController

@property (nonatomic,assign) WebViewBarButtonType finishButtonType;

+ (instancetype) controllerWithURL:(NSURL *)url title:(NSString *)title;

@end
