//
//  UIImage+Ext.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

- (NSData *)compressedJPEGData;

/*
 * Return a image already been decoded.
 * We can decode a image in background thread/queue, return it to main thread to reduce main thread consuming.
 */
- (UIImage *)decodedImage;

- (UIImage *)scaleImageToSize:(CGSize)size;
@end
