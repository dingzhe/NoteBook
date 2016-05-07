//
//  EmptyPlaceHolderView.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "EmptyPlaceHolderView.h"

@interface EmptyPlaceHolderView ()
{
    CGFloat _space;
}
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label;

@end

@implementation EmptyPlaceHolderView

- (void) initialize {
    _additionalTopOffset = 0.f;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.textAlignment = NSTextAlignmentCenter;
    [_label setFont:[UIFont middleFont]];
    [_label setTextColor:[UIColor lightGrayTextColor]];
    _label.numberOfLines = 2;
    _label.text = @"";
    [self addSubview: _imageView];
    [self addSubview: _label];
    
    _space = VIEW_MARGIN;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imgSize = _imageView.image!=nil?_imageView.image.size:CGSizeZero;
    [_imageView setFrame:CGRectMake(0, 0,imgSize.width, imgSize.height)];
    _imageView.center = CGPointMake(self.center.x, self.center.y - 20.f + _additionalTopOffset);
    
    CGRect labRect = [_label.text boundingRectWithSize:CGSizeMake(imgSize.width+100, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_label.font}  context:nil];
    [_label setFrame:CGRectMake((self.bounds.size.width - imgSize.width-100)/2,_imageView.frame.origin.y+_imageView.frame.size.height+_space, imgSize.width+100, labRect.size.height)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) setImage:(UIImage *)image {
    if (_image == image) {
        return;
    }
    _image = image;
    _imageView.image = image;
}

- (void) setString:(NSString *)string {
    if (_string == string) {
        return;
    }
    _string = string;
    _label.text = string;
}
@end
