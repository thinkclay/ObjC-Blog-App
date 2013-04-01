#import <UIKit/UIKit.h>
#import "JBTabBarController.h"
#import "JBTabBar.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    bool alertingUser;
    Reachability* reachability;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JBTabBarController *tabBarController;

// Static Methods
+(AppDelegate *)sharedAppDelegate;

// Instance Methods
-(void)customizeAppearance;
-(void)showAllFonts;
-(void)showUnreachableAlert;
-(void)checkNetworkConnection;
-(bool)appIsOnline;

@end
