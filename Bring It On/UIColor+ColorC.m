//
//  ColorC.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 08.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "UIColor+ColorC.h"
 
@implementation UIColor(ColorC)
 
+(CGColorRef)createRGBValue:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGFloat components[4] = {red, green, blue, alpha};
	CGColorRef color = CGColorCreate(colorspace, components);
	CGColorSpaceRelease(colorspace);
	return color;
}

+(UIColor *)colorFromRGBIntegers:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	CGFloat redF    = red/255;
	CGFloat greenF    = green/255;
	CGFloat blueF    = blue/255;
	CGFloat alphaF    = alpha/1.0;
	CGColorRef    color = [UIColor createRGBValue:redF green:greenF blue:blueF alpha:alphaF];
	return [UIColor colorWithCGColor:color];
}
 
@end
