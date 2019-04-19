#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
// #import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [GMSServices provideAPIKey:@"AIzaSyC-UZW-0_xR9GsMbUxJXb2nbhnyRkT_m5Q"];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
