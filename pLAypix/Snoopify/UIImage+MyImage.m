//
//  UIImage+MyImage.m
//  pLAypix
//
//  Created by Minakshi on 7/3/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "UIImage+MyImage.h"
#include <QuartzCore/QuartzCore.h>

@implementation UIImage (MyImage)


+ (void)beginImageContextWithSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(size, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
}

+ (void)endImageContext
{
    UIGraphicsEndImageContext();
}

+ (UIImage*)imageFromView:(UIView*)view
{
    [self beginImageContextWithSize:[view bounds].size];
    BOOL hidden = [view isHidden];
    [view setHidden:NO];
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    [view setHidden:hidden];
    return image;
}

+ (UIImage *) imageWithView:(UIView *)view
{
    
//    view.layer.backgroundColor = [UIColor clearColor].CGColor;
//    
//    CGFloat scale;
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
//        
//        scale = [[UIScreen mainScreen] scale];
//        
//    }
//    
//    else {
//        
//        scale = 0.0;    // mean use old api
//        
//    }
//    
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
//    } else {
//        UIGraphicsBeginImageContext(view.bounds.size);
//    }
//    
//    //UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
    
    
    
    //CGContextSetAlpha(context,0.5);
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return img;
    
}

+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize
{
    UIImage *image = [self imageFromView:view];
    if ([view bounds].size.width != newSize.width ||
        [view bounds].size.height != newSize.height) {
        image = [self imageWithImage:image scaledToSize:newSize];
    }
    return image;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    [self beginImageContextWithSize:newSize];
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    return newImage;
}


+ (UIImage *)croppedImage:(UIImage *)myImage :(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect(myImage.CGImage, bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
//    CGSize asd =  croppedImage.size;
    return croppedImage;
}


+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    
    CGImageRelease(mask);
    CGImageRelease(maskRef);
    return [UIImage imageWithCGImage:masked];
    
}

@end
