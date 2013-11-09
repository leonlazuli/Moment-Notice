//
//  futureEventsTableViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "futureEventsTableViewController.h"
#import "eventAddViewController.h"
#import "eventEditViewController.h"

@interface futureEventsTableViewController ()
@property MNEventList* eventList;
@property int selecedRow;
@end

@implementation futureEventsTableViewController

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// delete button
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.eventList deleteEventByIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

-(IBAction)unwindFromAddEvent:(UIStoryboardSegue*)segue
{

        eventAddViewController* eventAddVC = [segue sourceViewController];
        MNEvent *newevent = eventAddVC.event;
        if(newevent != Nil)
        {
            [self.eventList addEvent:newevent];
            [self.tableView reloadData];
        }
    
}

-(IBAction)unwindFromEditEvent:(UIStoryboardSegue*)segue
{
    
    eventEditViewController* eventAddVC = [segue sourceViewController];
    MNEvent *newevent = eventAddVC.event;
    if(newevent != Nil)
    {
        [self.eventList editEventByIndex:self.selecedRow withEvent:newevent];
        [self.tableView reloadData];
    }
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"eventTableToAdd"])
    {
        UINavigationController *navigator = [[UINavigationController alloc] init];
        navigator = [segue destinationViewController];
        eventAddViewController *eventAddVc = [[navigator viewControllers] lastObject];
        eventAddVc.user = self.user;
    }
    
    if([[segue identifier] isEqualToString:@"eventTableToEdit"])
    {
        UINavigationController *navigator = [[UINavigationController alloc] init];
        navigator = [segue destinationViewController];
        eventEditViewController *eventEditVc = [[navigator viewControllers] lastObject];
        eventEditVc.user = self.user;
        NSIndexPath *indexpath = [self.tableView indexPathForCell:sender];
        eventEditVc.event = [self.eventList fectchEventByIndex:indexpath.row];
        self.selecedRow = indexpath.row;
    }
    
}

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
    //demo
    self.eventList = [[MNEventList alloc] initWithUserFetchPastEvents:self.user];
    MNEvent* event = [[MNEvent alloc] init];
    event = [self.eventList fectchEventByIndex:0];
    NSLog(@"is there? %@\n",event.titile);
    //demo

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section. ?????????
    return [self.eventList count];
    //NSLog(@"%@", [self.eventList count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"futureEventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    MNEvent *event = [self.eventList fectchEventByIndex:indexPath.row];
    cell.textLabel.text = event.titile;
    cell.detailTextLabel.text = [event stringOfFromDate];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
