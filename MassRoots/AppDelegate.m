//
//  AppDelegate.m
//  MassRoots
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 Code With Ryan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "SearchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *vc = [[ViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.navController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSArray* components = [[url absoluteString] componentsSeparatedByString:@"="];
    NSString* code = [components lastObject];
    NSString *clientId = @"35f39c6844e4da2ff999";
    NSString *clientSecret = @"3f39b72e8c00cd4712a7bebca67c38eea8a4f681";

    NSString* curl = [NSString stringWithFormat:@"https://github.com/login/oauth/access_token?client_id=%@&client_secret=%@&code=%@", clientId, clientSecret, code];
    
    NSURL *accessUrl = [NSURL URLWithString:curl];
    NSURLRequest *request = [NSURLRequest requestWithURL:accessUrl];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *token = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", token);
        SearchViewController *searchVC = [[SearchViewController alloc]initWithStyle:UITableViewStylePlain];
        searchVC.userToken = token;
        self.navController.navigationBarHidden = NO;
        [self.navController pushViewController:searchVC animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@ %@", error, [error userInfo]);
        
    }];
    
    [operation start];

    
    
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
