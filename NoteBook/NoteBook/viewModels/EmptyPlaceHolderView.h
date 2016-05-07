//
//  EmptyPlaceHolderView.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyPlaceHolderView : UIView
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *string;

@property (nonatomic,assign) CGFloat additionalTopOffset;
@end
