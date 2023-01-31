#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
