//
//  AppDelegate.m
//  Snoopify
//
//  Created by Minakshi on 6/26/13.
//  Copyright (c) 2013 Minakshi. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstPage_iPad.h"
#import <StoreKit/StoreKit.h>
#import "RageIAPHelper.h"
#import "InAppRageIAPHelper.h"

@implementation AppDelegate

@synthesize sharePageObj, gestureFlag, isUserInterActionEnabled, newFlag;

@synthesize selectedImageFromTagPage, migoBtnFlag, singleTapFlag;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //[RageIAPHelper sharedInstance];
    
    //In app purchase
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppRageIAPHelper sharedHelper]];
    
    gestureFlag = FALSE;
    
    singleTapFlag = FALSE;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppStartupSound" ofType:@"mp3"];
    startupSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    startupSound.volume = 6.0;
    startupSound.delegate = self;
    [startupSound play];
    
    sleep(2);
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [self.window setFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[[FirstPage_iPad alloc] init] autorelease];
//    } else {
//        self.viewController = [[[FirstPage_iPad alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
//    }
    
//    SKProduct *product = product[buyButton.tag];
//    
//    NSLog(@"Buying %@...", product.productIdentifier);
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    //[userDefaults setBool:FALSE forKey:@"Page1"];
//    [userDefaults setInteger:0 forKey:@"Set1"];
//    [userDefaults synchronize];
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
