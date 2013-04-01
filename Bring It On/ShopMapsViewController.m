#import "ShopMapsViewController.h"
#import "Shop.h"
#import "CustomMKAnnotationView.h"

@interface ShopMapsViewController (Private)
-(void)close;
@end

@implementation ShopMapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo"]];
    
    // Set left button on nav
    UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon_transparent"] style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(close)];
    self.navigationItem.leftBarButtonItem = leftNavButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    Shop *shopItem = (Shop*)[self.shopItems objectAtIndex:0];

    // center the map
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = shopItem.lat;
    coordinate.longitude = shopItem.lng;
    self.mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
    
    [self.mapView addAnnotations:self.shopItems];
    
    annotationPos = 0;
}

- (MKAnnotationView *)mapView:(MKMapView*)mV viewForAnnotation:(id)annotation {
	if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
	
	// try to dequeue an existing pin view first
	static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
	CustomMKAnnotationView *pinView = (CustomMKAnnotationView*)
        [self.mapView dequeueReusableAnnotationViewWithIdentifier:BridgeAnnotationIdentifier];
	if (!pinView) {
		CustomMKAnnotationView* customPinView = [[CustomMKAnnotationView alloc]
											initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
		[customPinView setImage:[UIImage imageNamed:@"pin"] ];
        customPinView.canShowCallout = NO; // Not using the standard callout view
        customPinView.backgroundColor = [UIColor clearColor];
        customPinView.shopItem = [self.shopItems objectAtIndex:annotationPos];

        // To customize the callout view edit CustomCalloutView

		annotationPos++;
		return customPinView;
	} else {
		pinView.annotation = annotation;
	}
	return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	LogMethod();
}

-(void)close {
    LogMethod();
    [self dismissModalViewControllerAnimated:YES];
}

@end
