#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ShopsViewController.h"

@interface ShopMapsViewController : UIViewController <MKMapViewDelegate> {
    int annotationPos;
}

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) ShopsViewController *delegate;
@property (weak, nonatomic) NSMutableArray *shopItems;

@end
