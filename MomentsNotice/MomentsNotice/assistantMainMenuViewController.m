//
//  assistantMainMenuViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/22/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "assistantMainMenuViewController.h"
#import "futureEventsTableViewController.h"
#import "assistantPeopleViewController.h"
#import "pastEventViewController.h"

@interface assistantMainMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLable;

@end

@implementation assistantMainMenuViewController

//unwind function for the segue from Event
-(IBAction)unwindFromEventToAssistantMenu:(UIStoryboardSegue*)sender
{
    
}
-(IBAction)unwindFromEventToAssistantMenu22:(UIStoryboardSegue*)sender
{
    
}

-(IBAction)unwindFromPeopleToAssitantMenu:(UIStoryboardSegue*)sender
{
    
}

-(IBAction)unwindFromDataToAssistantMenu:(UIStoryboardSegue *)sender
{

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"assistantMenuToEvent"])
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
    else if([[segue identifier] isEqualToString:@"assistantMenuToPeople"])
    {
        UINavigationController *navigator = [[UINavigationController alloc] init];
        navigator = [segue destinationViewController];
        assistantPeopleViewController* peopleVC = [[navigator viewControllers] lastObject];
        peopleVC.user = self.user;
    }
    else if([[segue identifier] isEqualToString:@"assistantToPastEvent"])
    {
        UINavigationController *navigator = [[UINavigationController alloc] init];
        navigator = [segue destinationViewController];
        pastEventViewController* pastVC = [[navigator viewControllers] lastObject];
        pastVC.user = self.user;
    }
    else if([[segue identifier] isEqualToString:@"assistantToData"])
    {
        UINavigationController *navigator = [[UINavigationController alloc] init];
        navigator = [segue destinationViewController];
        pastEventViewController* pastVC = [[navigator viewControllers] lastObject];
        pastVC.user = self.user;
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
