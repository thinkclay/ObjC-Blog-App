#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

#import "NewsItem.h"
#import "GenericTableViewHeader.h"

@interface FindDetailViewController : UITableViewController

@property (strong, nonatomic) NewsItem *newsItem;
@property (strong, nonatomic) GenericTableViewHeader *headerView;
@property (strong, nonatomic) UIView *footerView;

@end
