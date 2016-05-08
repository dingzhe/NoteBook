//
// Created by 史伟夫 on 8/11/15.
// Copyright (c) 2015 shiweifu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MKPreviewControllerType) {
    MKPreviewControllerBlog,//博客类型，收藏，分享
    MKPreviewControllerNote, //笔记类型，编辑
    MKPreviewControllerDefault
};




@interface MKPreviewController : UIViewController
@property (nonatomic, assign) MKPreviewControllerType type;
@property (nonatomic, strong) NSString *bodyMarkdown;

@property (nonatomic, copy) void (^onComplete) (MKPreviewController *);

@property (nonatomic, copy) void (^onclickBarBtn) (UIBarButtonItem *);
@end
