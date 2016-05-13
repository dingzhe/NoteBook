//
//  AboutViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "AboutViewController.h"
#import "Masonry.h"

@implementation AboutViewController
+ (instancetype) viewController {
    AboutViewController *result = [[self alloc] init];
    result.hidesBottomBarWhenPushed = YES;
    return result;
}
-(void)viewDidLoad{
    self.title = @"关于《记着》";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    [self.view addSubview:imageView];
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];

    UILabel *version = [[UILabel alloc] initWithFrame:CGRectZero];
    version.text = @"V 1.0";
    [version setTextColor:[UIColor lightGrayTextColor]];
    [version setFont:[UIFont middleFont]];
    [self.view addSubview:version];
    [version mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(60);
        make.size.mas_equalTo(CGSizeMake(30, 20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLab.text = @"记着";
    [nameLab setTextColor:[UIColor darkGrayTextColor]];
    [nameLab setFont:[UIFont largeFont]];
    [self.view addSubview:nameLab];
    [nameLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(version.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];

}


@end
