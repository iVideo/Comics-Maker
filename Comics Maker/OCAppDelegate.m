//
//  OCAppDelegate.m
//  Comics Maker
//
//  Created by -----> Lucas Augusto Cordeiro <-----, Emannuel Fernandes de Oliveira Carvalho e Rodrigo Soldi on 2/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCTableViewController.h"
//#import "OCTirinhasSingleton.h"
#import "OCPrimeiraView.h"

@implementation OCAppDelegate
@synthesize memoryCard;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ipad" bundle:nil];
//    } else {
//        [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    }
    
    
    
    
    // Override point for customization after application launch.
//    OCTirinhasSingleton* sing = [[OCTirinhasSingleton alloc]init];
//    sing = [memoryCard objectForKey:@"save"];
    
    
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *viewController;
//    
//    if(sing.tirinhas.count==0)
//        viewController = [storyboard instantiateViewControllerWithIdentifier:@"primeiraView"];
//    else
//        viewController = [storyboard instantiateViewControllerWithIdentifier:@"TabelaViewController"];
//    
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];
    
    
//    OCTableViewController  *rootController = (OCTableViewController *) [navigationController.viewControllers objectAtIndex:0];
//    rootController.bugs = loadedBugs;
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

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    NSUInteger orientations = UIInterfaceOrientationMaskAllButUpsideDown;
//    
//    if(self.window.rootViewController){
//        UIViewController *presentedViewController = [[(UINavigationController *)self.window.rootViewController viewControllers] lastObject];
//        orientations = [presentedViewController supportedInterfaceOrientations];
//    }
//    
//    return orientations;
//}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    OCTirinhasSingleton *sing = [[OCTirinhasSingleton alloc]init];
//    [memoryCard setObject:sing forKey:@"save"];
}

@end
