#import "AppDelegate.h"
#import "FindViewController.h"
#import "ShopsViewController.h"
#import "AboutViewController.h"

@implementation AppDelegate

@synthesize tabBarController;

#pragma mark -
#pragma mark Static methods

+(AppDelegate *)sharedAppDelegate {
	return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark -
#pragma mark Application delegate callback methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    #if !TARGET_IPHONE_SIMULATOR
    // Register Device for Push Notifications
    // [[UIApplication sharedApplication]
    //    registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    // Please keep in mind, you need to provide your own provisoning profile with push messaging enabled and also setup a backend server
    // that will handle device tokens and communicate with the apple push gateway! It won't work in the simulator..
    // Please read: http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html
    #endif

    // Appearance Customization
    [self customizeAppearance];
    
    // Custom Tab Bar
    self.tabBarController = [[JBTabBarController alloc] init];
    NSMutableArray* controllers = [NSMutableArray arrayWithObject:[[UINavigationController alloc] initWithRootViewController:[[FindViewController alloc] init]]];
    [controllers addObject:[[UINavigationController alloc] initWithRootViewController:[[ShopsViewController alloc] init]]];
    [controllers addObject:[[UINavigationController alloc] initWithRootViewController:[[AboutViewController alloc] init]]];
    
    tabBarController.viewControllers = controllers;
    tabBarController.tabBar.maximumTabWidth = 64.0f;
    tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"bg_tabs"];
    tabBarController.tabBar.layoutStrategy = JBTabBarLayoutStrategyFill;
    tabBarController.tabBar.layoutBlock = ^(JBTab *tab, NSUInteger index, NSUInteger numberOfTabs) {
        if (tabBarController.tabBar.bounds.size.width/numberOfTabs < tabBarController.tabBar.bounds.size.height) {
            CGFloat tabWidth = tabBarController.tabBar.bounds.size.width/numberOfTabs;
            tab.frame = CGRectMake(tabWidth*index, (tabBarController.tabBar.bounds.size.height-tabWidth)/2, tabWidth, tabWidth);
        } else {
            CGFloat tabHeight = tabBarController.tabBar.bounds.size.height;
            CGFloat horizontalOffset = (tabBarController.tabBar.bounds.size.width - numberOfTabs*tabHeight)/2;
            tab.frame = CGRectMake(horizontalOffset + tabHeight*index, 0.0, tabHeight, tabHeight);
        }
    };

    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

// Appearance Customization
-(void)customizeAppearance {
    // Nav Bar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"ui_navbar"]
                                       forBarMetrics:UIBarMetricsDefault];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"default_navbar_button"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(4, 5, 4, 5)];
    
    // Back button nav bar items
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-2.0f, 1.0f)
                                                         forBarMetrics:UIBarMetricsDefault];
    // Regular nav bar items
    [[UIBarButtonItem appearance] setBackgroundImage:backButtonImage forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:backButtonImage forState:UIControlStateHighlighted
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:backButtonImage forState:UIControlStateSelected
                                          barMetrics:UIBarMetricsDefault];
}

-(void)showAllFonts {
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily) {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont) {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)checkNetworkConnection {
    NSLog(@"checkNetworkConnection");
    reachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if(remoteHostStatus == NotReachable) {
		[self showUnreachableAlert];
	}
}

-(bool)appIsOnline {
    reachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    return !(remoteHostStatus == NotReachable);
}

/** Shows the unreachable alert */
- (void) showUnreachableAlert {
	[self showAlert:NSLocalizedString(@"Network Problem", nil)
		 andMessage:NSLocalizedString(@"This app requires an internet connection!", nil)];
}

- (void) showAlert:(NSString *)title andMessage:(NSString*)message {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	if (!alertingUser) {
		alertingUser = YES;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
														message:message
													   delegate:self
											  cancelButtonTitle:NSLocalizedString(@"OK", nil)
											  otherButtonTitles:nil];
        alert.tag = 99999;
		[alert show];
	}
}

#pragma mark -
#pragma mark Push Notification delegation methods

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	NSLog(@"Device Token: %@", [devToken description]);
    // Send this device token to your backend
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    LogMethod();

	if (userInfo) {
		NSDictionary *aps = [userInfo objectForKey:@"aps"];
		
		UIAlertView *messageAlert = [[UIAlertView alloc]
									 initWithTitle:@"Bring It On"
									 message:[aps objectForKey:@"alert"]
									 delegate:nil
									 cancelButtonTitle:NSLocalizedString(@"OK", nil)
									 otherButtonTitles:nil];
        [messageAlert show];
	}
}

@end
