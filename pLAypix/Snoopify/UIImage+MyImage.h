//
//  UIImage+MyImage.h
//  pLAypix
//
//  Created by Minakshi on 7/3/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyImage)

+ (UIImage*)imageFromView:(UIView*)view;
+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)beginImageContextWithSize:(CGSize)size;
+ (UIImage *)croppedImage:(UIImage *)myImage :(CGRect)bounds;
+ (UIImage *) imageWithView:(UIView *)view;

//masking the image ....

+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;

@end
