#import "AboutViewController.h"
#import "JBTabBarController.h"

@interface AboutViewController (Private)
@end

@implementation AboutViewController

- (id) initWithNibName: (NSString *) nibNameOrNil bundle:(NSBundle *) nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
    if ( self )
	{
        // Tab Bar
        self.tabBarItem.image = [UIImage imageNamed: @"tab_about"];
        self.tabBarItem.selectedImage = [UIImage imageNamed: @"tab_about_selected"];
        
        // Nav Bar
        self.navigationItem.backBarButtonItem.title = @"Back";
    }
	
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Remove title from back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle: @" " style: UIBarButtonItemStyleBordered target: nil action: nil];
	
    [[self navigationItem] setBackBarButtonItem: backButton];
    
    // Set Logo in Navbar
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"icon_logo"]];
	
	
	CGRect labelFrame = CGRectMake(20, 20, 280, 150);
    UILabel *aboutText = [[UILabel alloc] initWithFrame:labelFrame];
	UIFont *noteworthy = [UIFont fontWithName: @"Noteworthy" size: 16];
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_maze_white.png"]];
    NSString *labelText = @"Bring It On was developed to combine challenges with local adventures. Whether it's challenging your friends to a bar crawl or a race around the block, or you just want to chill and do some geocaching, you'll be able to do it all in one place and share your challenges on your social sphere and with other people in your area. Create custom badges or rewards to take your challenges up a notch and rein supreme as the best at what you do!";
	UIImageView *octo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 346)];
	
	octo.image = [UIImage imageNamed: @"logo_large_white.png"];
	
	aboutText.backgroundColor	= [UIColor clearColor];
	aboutText.font				= noteworthy;
	aboutText.text				= labelText;
	aboutText.numberOfLines		= 0;
	aboutText.sizeToFit;
	
	/**
	 * Interesting note here:
	 *
	 * aboutText.sizeToFit
	 * [aboutText sizeToFit];
	 *
	 * is semantically and syntactically correct,
	 * so it'll be an interesting use case for how this will look in MacRuby
	 */
	

	[self.view setBackgroundColor: background];
	[self.view addSubview:octo];
    [self.view addSubview:aboutText];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) toInterfaceOrientation
{
    return YES;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (void) viewDidUnload
{
	[super viewDidUnload];
}
@end
