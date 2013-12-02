//
//  MNAppDelegate.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNAppDelegate.h"
#import <Parse/Parse.h>


@implementation MNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"4mIYh47LSZRVa43ZQrgwqPj4yhy69KnqK5NcMyox"
                  clientKey:@"OD4g4lHq96YvVam52wbQhRQeeLnUUht9Ipy0NUE3"];
    
    sleep(3);
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    

    // Override point for customization after application launch.
    return YES;
}



// If the app is in the foreground the notification is automatically dismissed.
// This is so that an alert pops up all the time
// Very similar to didFinishLauncingWithOptions
- (void) application: (UIApplication *) application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *notifyAlert = [[UIAlertView alloc]
                                initWithTitle: @"Moment's Notice"
                                message: @"Event upcoming soon! \n Please go mark the event as \"remembered\""
                                delegate: nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil];
    [notifyAlert show];
    [self performSelector:@selector(dismissAlertView:) withObject:notifyAlert afterDelay:5];
}

//  Function for alert dismissal. Called in performSelector
-(void) dismissAlertView:(UIAlertView *) alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}


//   This method allows you to call methods after pressing buttons in an alert. Specifically designed for above alert
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        //Checks to see if OK button was selected
        NSLog(@"OK was selected");
    }
    else if (buttonIndex == alertView.cancelButtonIndex+1)
    {
        //Checks to see if Show me button was selected
        NSLog(@"Show me was selected");
    }
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
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
