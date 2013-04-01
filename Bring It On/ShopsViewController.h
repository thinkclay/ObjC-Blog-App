#import <UIKit/UIKit.h>
#import "GenericTableViewHeader.h"

@interface ShopsViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *shopItems;
@property (strong, nonatomic) GenericTableViewHeader *headerView;

@end
