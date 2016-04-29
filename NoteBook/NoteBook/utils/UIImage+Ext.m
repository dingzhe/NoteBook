//
//  UIImage+Ext.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIImage+Ext.h"

@implementation UIImage (Ext)
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1,1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = cornerRadius * 2 + 1;
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

- (NSData *)compressedJPEGData{
    
    // 0.75 lossy compresss quality is almost default compress quality of ImageIO.
    return UIImageJPEGRepresentation(self, .75f);
    
    // For compability reason, drop ImageIO
    /*
     NSMutableData *result = [NSMutableData data];
     
     CGImageDestinationRef tmpImgDes = NULL;
     tmpImgDes = CGImageDestinationCreateWithData((CFMutableDataRef)result, kUTTypeJPEG, 1, NULL);
     
     CGImageDestinationAddImage(tmpImgDes, self.CGImage, NULL);
     CGImageDestinationFinalize(tmpImgDes);
     CFRelease(tmpImgDes);
     
     return result;
     */
}

- (UIImage *)decodedImage {
    return [self scaleImageToSize:self.size];
}

- (UIImage *)scaleImageToSize:(CGSize)size {
    UIImage *result = nil;
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];
    result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}
@end
