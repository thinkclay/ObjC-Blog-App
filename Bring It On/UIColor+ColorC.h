//
//  ColorC.h
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 08.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

@interface UIColor(ColorC)
 
+(UIColor *)colorFromRGBIntegers:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(CGColorRef)createRGBValue:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
 
@end
