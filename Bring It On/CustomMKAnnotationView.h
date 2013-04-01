//
//  CustomMKAnnotationView.h
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 21.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CustomCalloutView.h"
#import "Shop.h"

@interface CustomMKAnnotationView : MKAnnotationView

@property (strong, nonatomic) CustomCalloutView *customCalloutView;
@property (weak, nonatomic) Shop *shopItem;

@end
