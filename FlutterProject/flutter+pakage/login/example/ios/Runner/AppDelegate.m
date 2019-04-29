#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "LoginPlugin.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    FlutterMethodChannel * batteryChannel = [FlutterMethodChannel methodChannelWithName: @"login" binaryMessenger: controller];

    [batteryChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
       [self login];
    }];
    
    
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)login {
    printf("login");
}

- (int)getBatteryLevel {
    UIDevice* device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return -1;
    } else {
        return (int)(device.batteryLevel * 100);
    }
}

@end
