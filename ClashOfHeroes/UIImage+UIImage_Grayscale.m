//
//  UIImage+UIImage_Grayscale.m
//  ClashOfHeroes
//
//  Created by Chris Kievit on 31-01-12.
//  Copyright (c) 2012 Pro4all. All rights reserved.
//

#import "UIImage+UIImage_Grayscale.h"

@implementation UIImage (UIImage_Grayscale)

- (UIImage *)grayScale
{
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    CGContextDrawImage(context, imageRect, [self CGImage]);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CFRelease(imageRef);
    
    return newImage;
}

@end
