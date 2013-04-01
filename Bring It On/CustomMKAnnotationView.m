//
//  CustomMKAnnotationView.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 21.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "CustomMKAnnotationView.h"

@implementation CustomMKAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    LogMethod();
    [super setSelected:selected animated:animated];

    if (selected) {
        NSLog(@"Pin selected!");
        if (self.customCalloutView == nil) {
            self.customCalloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(-74, -82, 171, 80)];
            self.customCalloutView.titleLabel.text = self.shopItem.title;
            self.customCalloutView.streetLabel.text = self.shopItem.street;
            self.customCalloutView.cityLabel.text = [NSString stringWithFormat:@"%@ %@", self.shopItem.zipcode, self.shopItem.city];
        }
        [self addSubview:self.customCalloutView];
    } else {
        NSLog(@"Pin unselected!");
        [self.customCalloutView removeFromSuperview];
    }
}

@end
