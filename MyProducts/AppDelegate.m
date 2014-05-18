//
//  AppDelegate.m
//  MyProducts
//
//  Created by Ziyang Tan on 5/16/14.
//  Copyright (c) 2014 ziyang. All rights reserved.
//

#import "AppDelegate.h"
#import "ProductModel.h"
#import "ProductDatabase.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
//    NSArray *productJsonArray = [ProductModel arrayOfModelsFromData:jsonData error:nil];
//    for (ProductModel *product in productJsonArray) {
//        [[ProductDatabase sharedDatabase] insertProduct:product];
//    }
//    
//    NSArray *productArray = [ProductDatabase sharedDatabase].productInfoArray;
//     for (ProductModel *info in productArray) {
//        NSLog(@"%@", info);
//     }
//    
//    ((ProductModel*)[productJsonArray objectAtIndex:0]).descriptionText = @"test";
//    [[ProductDatabase sharedDatabase] updateProduct:[productJsonArray objectAtIndex:0]];
//    
//    productArray = [ProductDatabase sharedDatabase].productInfoArray;
//    for (ProductModel *info in productArray) {
//        NSLog(@"after update\n\n%@", info);
//    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f]}];
    [[UINavigationBar appearance] setTintColor:[UIColor colorFromHexString: @"#FF5E3A"]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor colorFromHexString: @"#FF5E3A"]]];

    return YES;
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

@end
