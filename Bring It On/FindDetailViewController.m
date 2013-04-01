#import "FindDetailViewController.h"
#import "NewsDetailTopCell.h"
#import "NewsDetailBottomCell.h"
#import "Stylesheet.h"

@interface FindDetailViewController (Private)
-(void)setupTableViewHeader;
-(void)back;
-(void)shareNews;
@end

@implementation FindDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set Logo in Navbar
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_logo"]];

    // Table View
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorFromRGBIntegers:243 green:243 blue:243 alpha:1.0];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Table View Header
    [self setupTableViewHeader];

    // Overridden back button to add a custom icon!
    // Set left button on nav
    UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon_transparent"] style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftNavButton;

    // Set right button on nav
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(shareNews)];
    self.navigationItem.rightBarButtonItem = rightNavButton;
}

-(void)back {
    LogMethod();
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)shareNews {
    LogMethod();
    
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    NSString *tweetString = [NSString stringWithFormat:@"News: %@", self.newsItem.title];
    if ([tweetString length] > 140) {
        tweetString = [tweetString substringToIndex: MIN(140, [tweetString length])];
    }
    
    [twitter setInitialText:tweetString];
    
    if (self.newsItem.url) {
        [twitter addURL:[NSURL URLWithString:self.newsItem.url]];
    }
    
    [self presentModalViewController:twitter animated:YES];
    
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        [self dismissModalViewControllerAnimated:YES];
    };
}

-(void)setupTableViewHeader {
    if (self.headerView == nil) {
        self.headerView = [[GenericTableViewHeader alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 47.0)];
        self.headerView.headerTitle.text = @"NEWS ITEM";
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"NewsDetailTopCell";
        NewsDetailTopCell *cell = (NewsDetailTopCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NewsDetailTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.titleLabel1.text = [NSString stringWithFormat:@"%@ | %@", self.newsItem.date, self.newsItem.author];
        if ([self.newsItem.headline length] > 60) {
            cell.titleLabel2.text = [NSString stringWithFormat:@"%@...", [self.newsItem.headline substringToIndex: MIN(60, [self.newsItem.headline length])]];
        } else {
            cell.titleLabel2.text = self.newsItem.headline;
        }
        cell.detailImageView.image = [UIImage imageNamed:self.newsItem.detailImageName];

        return cell;
    } else {
        static NSString *CellIdentifier = @"NewsDetailBottomCell";
        NewsDetailBottomCell *cell = (NewsDetailBottomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NewsDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        NSString *text = [NSString stringWithFormat:@"<html><head></head>"
                          "<body style=\"background-color:transparent; \">"
                          "<span style=\"color: #5d5c5c; font-size: 14px; font-family:'Open Sans';\">%@</span></body></html>",
                          self.newsItem.text];
		[cell.textView loadHTMLString:text baseURL:nil];

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
        if (self.newsItem.detailImageName) {
            // news item with image
            return 214.0;
        } else {
            // news item without image
            return 74.0;
        }
    } else {
		// Calculates the height of a summary        
        CGSize s;
        
        if (UIInterfaceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
            s = [self.newsItem.text sizeWithFont:[Stylesheet smallFont]
                               constrainedToSize:CGSizeMake(180.0, MAXFLOAT)
                                   lineBreakMode:UILineBreakModeWordWrap];
        } else {
            s = [self.newsItem.text sizeWithFont:[Stylesheet smallFont]
                               constrainedToSize:CGSizeMake(220.0, MAXFLOAT)
                                   lineBreakMode:UILineBreakModeWordWrap];
        }

		return s.height + 20.0; // Adding bottom margin of 20px
	}
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

@end
