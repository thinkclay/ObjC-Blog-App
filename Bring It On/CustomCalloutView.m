//
//  CustomCalloutView.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 21.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "CustomCalloutView.h"
#import "Stylesheet.h"

@implementation CustomCalloutView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        LogMethod();
        self.backgroundColor = [UIColor clearColor];
        
        // Custom background for callout
        UIImage *image = [UIImage imageNamed:@"overlay_background"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 7.0, 169.0, 18.0)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [Stylesheet largeFont];
        self.titleLabel.textColor = [UIColor colorFromRGBIntegers:32 green:151 blue:153 alpha:1.0];
        self.titleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.titleLabel.shadowOffset = CGSizeMake(1, 1);
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.streetLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 30.0, 169.0, 18.0)];
        self.streetLabel.backgroundColor = [UIColor clearColor];
        self.streetLabel.font = [Stylesheet smallFont];
        self.streetLabel.textColor = [Stylesheet darkTextColor];
        self.streetLabel.shadowColor = [Stylesheet labelShadowColor];
        self.streetLabel.shadowOffset = CGSizeMake(1, 1);
        self.streetLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.streetLabel];
        
        self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 48.0, 169.0, 18.0)];
        self.cityLabel.backgroundColor = [UIColor clearColor];
        self.cityLabel.font = [Stylesheet smallFont];
        self.cityLabel.textColor = [Stylesheet darkTextColor];
        self.cityLabel.shadowColor = [Stylesheet labelShadowColor];
        self.cityLabel.shadowOffset = CGSizeMake(1, 1);
        self.cityLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.cityLabel];
    }
    
    return self;
}

@end
