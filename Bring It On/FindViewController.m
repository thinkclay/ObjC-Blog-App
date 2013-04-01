#import "FindViewController.h"
#import "FindDetailViewController.h"
#import "JBTabBarController.h"
#import "NewsListTableViewCell.h"
#import "NewsItem.h"
#import "NSString+HTML.h"
#import "AppDelegate.h"

@interface FindViewController (Private)
-(void)setupTableViewHeader;
-(void)reloadNews;
-(void)loadData;
-(void)loadDataFromWebservice;
-(void)loadDataFromFeed;
@end

// TODO Customize: If you want to load the news via an RSS/Atom feed,
// please set LoadNewsFromFeed to YES and enter the URL below...
bool const LoadNewsFromFeed = YES;
NSString* const FeedUrl = @"http://feeds.feedburner.com/TechCrunch/startups";
///

@implementation FindViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Tab Bar: Brand new tab item
        self.tabBarItem.image = [UIImage imageNamed:@"tab_find"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_find_selected"];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set Logo in Navbar
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo"]];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    // Set right button on nav
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reload_icon"] style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(reloadNews)];
    self.navigationItem.rightBarButtonItem = rightNavButton;
    
    // Table View
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorFromRGBIntegers:243 green:243 blue:243 alpha:1.0];
    
    // Table View Header
    [self setupTableViewHeader];
}

-(void)setupTableViewHeader {
    if (self.headerView == nil) {
        self.headerView = [[GenericTableViewHeader alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 47.0)];
        self.headerView.headerTitle.text = @"Find Challenges";
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.newsItems == nil) {
        self.newsItems = [[NSMutableArray alloc] init];
    }

    if ([self.newsItems count] == 0) {
        [self loadData];
    }
}

#pragma mark - Data loading methods

/** Dispatches to the appropriate data loading method. **/
-(void)loadData {
    if ([[AppDelegate sharedAppDelegate] appIsOnline]) {
        if (LoadNewsFromFeed) {
            [self loadDataFromFeed];
        } else {
            [self loadDataFromWebservice];
        }
    } else {
        NSLog(@"Offline: Using cached news items...");
        self.newsItems = [NewsItem loadNewsItems];
        [self.tableView reloadData];
    }
}

/** Starts to load news from your own webservice on the web. **/
-(void)loadDataFromWebservice {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // TODO Customize: insert your own code here to load your data via a JSON/XML webservice
        // you can use ASIHTTPRequest for example...
        sleep(1.5);
        
        NewsItem *newsItem = [[NewsItem alloc] init];
        newsItem.title = @"COPENHAGEN BIKE SHOPS";
        newsItem.date = @"22.06.2012";
        newsItem.author = @"S. Wright";
        newsItem.headline = @"One of the cities\nwith the coolest bikes.";
        newsItem.detailImageName = @"shop_image";
        newsItem.text = @"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
        
        [self.newsItems addObject:newsItem];
        
        // Save for offline use
        [NewsItem saveNewsItems:self.newsItems];
        
        [self.tableView reloadData];
        ///
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

/** Starts to load the RSS/Atom feed. Checkout the callback methods down belown. **/
-(void)loadDataFromFeed {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (self.feedParser == nil) {
        self.feedParser = [[MWFeedParser alloc] initWithFeedURL:[NSURL URLWithString:FeedUrl]];
        self.feedParser.delegate = self;
        self.feedParser.feedParseType = ParseTypeFull;
        self.feedParser.connectionType = ConnectionTypeAsynchronously;
    }
    [self.feedParser parse];
}

/** Used with the reload button in the nav bar is pressed. **/
-(void)reloadNews {
    LogMethod();
    self.newsItems = nil;
    self.newsItems = [[NSMutableArray alloc] init];
    [self.tableView reloadData];
    [self loadData];
}

#pragma mark -
#pragma mark MWFeedParserDelegate methods

/**
 * Feed parsing started, so the loading overlay is being shown.
 */
- (void)feedParserDidStart:(MWFeedParser *)parser {
	NSLog(@"feedParserDidStart");
}

/** Information about the feed itself **/
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"didParseFeedInfo: %@", info);
    self.feedInfo = info;
}

/** Processes a single feed item. */
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	// NSLog(@"didParseFeedItem: %@", item);
    
    // creates an instance to nsdataformatter for reuse.
	if (formatter == nil) {
		formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd.MM.YYYY"]; // european date format / use MM/dd/YY h:m a for american date format
		// [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]]; set your timezone if necessary
	}
    
    NewsItem *newsItem = [[NewsItem alloc] init];
    newsItem.title = item.title ? item.title : @"No title";
    newsItem.headline = newsItem.title;
    if (item.date != nil) {
        newsItem.date = [formatter stringFromDate:item.date];
    }
    newsItem.author = (self.feedInfo && self.feedInfo.title) ? self.feedInfo.title : @"No feed title";
    
    if (item.summary != nil) {
        newsItem.text = [item.summary stringByConvertingHTMLToPlainText];
    }
    
    if (item.link != nil) {
        newsItem.url = item.link;
    }
    
    if (item.enclosures != nil && [item.enclosures count] > 0) {
        NSDictionary *enclosureItem = [item.enclosures objectAtIndex:0];
        if (enclosureItem != nil && [enclosureItem objectForKey:@"url"] != nil) {
            newsItem.imageUrl = [enclosureItem objectForKey:@"url"];
            // NSLog(@"Image URL: %@", newsItem.imageUrl);
        }
    }

    [self.newsItems addObject:newsItem];
}

/**
 * Callback when parsing finishes to sort the feed items and put them in an array.
 */
- (void)feedParserDidFinish:(MWFeedParser *)parser {
	NSLog(@"feedParserDidFinish");

    dispatch_async(dispatch_get_main_queue(), ^{
        // Save news items for offline use
        if (self.newsItems && [self.newsItems count] > 0) {
            [NewsItem saveNewsItems:self.newsItems];
        }

        sleep(1.5);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });

    [self.tableView reloadData];
}

/** Parsing failed. */
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.newsItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"NewsListCell";
    NewsListTableViewCell *cell = (NewsListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NewsListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NewsItem *item = [self.newsItems objectAtIndex:indexPath.row];

    cell.titleLabel.text = item.title;
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%@ | %@", item.date, item.author];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.0;
}

#pragma mark - Table view footer

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.footerView == nil) {
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)];
        self.footerView.backgroundColor = [UIColor clearColor];
    }
    return self.footerView;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FindDetailViewController *detailViewController = [[FindDetailViewController alloc] initWithNibName:@"NewsDetailViewController" bundle:nil];
    detailViewController.newsItem = [self.newsItems objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
