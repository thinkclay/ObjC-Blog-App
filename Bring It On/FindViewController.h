#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "GenericTableViewHeader.h"

extern bool const LoadNewsFromFeed;
extern NSString* const FeedUrl;

@interface FindViewController : UITableViewController <MWFeedParserDelegate> {
@private
    bool _reloading;
    NSDateFormatter *formatter;
}

@property (strong, nonatomic) NSMutableArray *newsItems;
@property (strong, nonatomic) GenericTableViewHeader *headerView;
@property (strong, nonatomic) MWFeedParser *feedParser;
@property (strong, nonatomic) MWFeedInfo *feedInfo;
@property (strong, nonatomic) UIView *footerView;

@end
