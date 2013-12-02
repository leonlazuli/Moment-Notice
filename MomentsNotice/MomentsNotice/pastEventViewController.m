//
//  pastEventViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/29/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "pastEventViewController.h"
#import "MNEventList.h"
#import "primaryMainMenuViewController.h"
#import "assistantMainMenuViewController.h"

@interface pastEventViewController ()

@property (strong, nonatomic) MNEventList* eventList;

@end

@implementation pastEventViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //you need to initial the eventlist here
   // NSLog(@"past user name %@", self.user.userID);
    self.eventList = [[MNEventList alloc] initWithUserFetchAllPastEvents:self.user];

    

}
- (IBAction)back:(id)sender
{
    if(self.user.userType == PRIMARY_USER)
        [self performSegueWithIdentifier:@"pastEventToPrimary" sender:self];
    else if(self.user.userType == ASSISTANT_USER)
        [self performSegueWithIdentifier:@"pastEventToAssistant" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"pastEventToPrimary"])
    {
        primaryMainMenuViewController* VC = [segue destinationViewController];
        VC.user = self.user;
    }
    if([[segue identifier] isEqualToString:@"pastEventToAssistant"])
    {
        assistantMainMenuViewController* VC = [segue destinationViewController];
        VC.user = self.user;
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.eventList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"pastEventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MNEvent *event = [self.eventList fectchEventByIndex:indexPath.row];
    cell.textLabel.text = event.title;
    cell.detailTextLabel.text = [event stringOfFromDate];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
