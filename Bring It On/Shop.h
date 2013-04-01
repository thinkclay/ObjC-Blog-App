//
//  Shop.h
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 15.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Shop : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *zipcode;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *website;
@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lng;

// required for the map annotation
@property (readwrite, nonatomic) CLLocationCoordinate2D coordinate;

@end
