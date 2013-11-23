//
//  primaryMainMenuViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "primaryMainMenuViewController.h"
#import "futureEventsTableViewController.h"
#import "primaryPeopleViewController.h"


@interface primaryMainMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLable;

@end

@implementation primaryMainMenuViewController

//unwind function for the segue from Event
-(IBAction)unwindFromEvent:(UIStoryboardSegue*)sender
{
    
}

-(IBAction)unwindFromPeopleToPrimaryMenu:(UIStoryboardSegue*)sender
{
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"primaryMenuToEvent"])
    {
        UINavigationController* navigationController = [[UINavigationController alloc] init];
        //use the segue to fetch the tabbarcontroller
        UITabBarController* tbc = [segue destinationViewController];
        //user the tabbarcontroller to fetch the navigationcontroller
        navigationController = (UINavigationController*)[[tbc customizableViewControllers] objectAtIndex:0];
        //use the navigationController to fecth the editEventController object
        futureEventsTableViewController *futureEventsTVC = [[navigationController viewControllers] lastObject];
        futureEventsTVC.user = self.user;
    }
    else if([[segue identifier] isEqualToString:@"primaryMenuToPeople"])
    {
        UINavigationController *navigator = [[UINavigationController alloc] init];
        navigator = [segue destinationViewController];
        primaryPeopleViewController* peopleVC = [[navigator viewControllers] lastObject];
        peopleVC.user = self.user;
    }

}

//the setter for user, and we also set the welcome lable in this setter
-(void) setUser:(MNUser *)user
{
    _user = user;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *welcomeStr = [[NSString alloc] initWithFormat:@"Welcome to MomentsNotice!  %@ ", self.user.nickName ];
    self.welcomeLable.text = welcomeStr;
	// Do any additional setup after loading the view.
}



@end
