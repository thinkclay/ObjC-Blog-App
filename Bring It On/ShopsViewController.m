#import "ShopsViewController.h"
#import "JBTabBarController.h"
#import "ShopsListTableViewCell.h"
#import "Shop.h"
#import "ShopMapsViewController.h"

@interface ShopsViewController (Private)
-(void)showMap;
@end

@implementation ShopsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Tab Bar
        self.tabBarItem.image = [UIImage imageNamed:@"tab_create"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_create_selected"];
        
        // Nav Bar
        self.navigationItem.backBarButtonItem.title = @"Back";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
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
    
    // Set right button on nav
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"map_icon"] style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(showMap)];
    self.navigationItem.rightBarButtonItem = rightNavButton;
    
    self.shopItems = [[NSMutableArray alloc] init];
    
    // TODO: load via JSON/XML webservice
    
    Shop *item = [[Shop alloc] init];
    item.title = @"CYKELBANDITTEN";
    item.street = @"Vesterbrogade 108";
    item.zipcode = @"1620";
    item.city = @"Copenhagen, DK";
    item.phone = @"+45 3513 1993";
    item.website = @"www.cykelbanditten.dk";
    item.lat = 55.671614;
    item.lng = 12.5452;
    CLLocationCoordinate2D shopItemCoordinate;
    shopItemCoordinate.latitude = item.lat;
    shopItemCoordinate.longitude = item.lng;
    item.coordinate = shopItemCoordinate;

    Shop *item2 = [[Shop alloc] init];
    item2.title = @"GREAT STORE";
    item2.street = @"1000 Broadway";
    item2.zipcode = @"10111";
    item2.city = @"New York, NY, USA";
    item2.phone = @"+1 111 2222";
    item2.website = @"www.great-store.com";
    item2.lat = 40.7423137;
    item2.lng = -73.9890169;
    CLLocationCoordinate2D shopItemCoordinate2;
    shopItemCoordinate2.latitude = item2.lat;
    shopItemCoordinate2.longitude = item2.lng;
    item2.coordinate = shopItemCoordinate2;
    
    [self.shopItems addObject:item];
    [self.shopItems addObject:item2];
}

-(void)showMap {
    LogMethod();
    ShopMapsViewController *vc = [[ShopMapsViewController alloc] initWithNibName:@"ShopMapsViewController" bundle:nil];
    vc.delegate = self;
    vc.shopItems = self.shopItems;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentModalViewController:navController animated:YES];
}

-(void)setupTableViewHeader {
    if (self.headerView == nil) {
        self.headerView = [[GenericTableViewHeader alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 47.0)];
        self.headerView.headerTitle.text = @"VISIT US";
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
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
    return [self.shopItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ShopsListCell";
    ShopsListTableViewCell *cell = (ShopsListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShopsListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Shop *shopItem = [self.shopItems objectAtIndex:indexPath.row];
    cell.shopItem = shopItem;
    cell.titleLabel.text = shopItem.title;
    cell.subTitleLabel.text = [NSString stringWithFormat:@"%@ | %@ %@", shopItem.street, shopItem.zipcode, shopItem.city];
    [cell.phoneButton setTitle:[NSString stringWithFormat:@"T %@", shopItem.phone] forState:UIControlStateNormal];
    [cell.websiteButton setTitle:shopItem.website forState:UIControlStateNormal];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
