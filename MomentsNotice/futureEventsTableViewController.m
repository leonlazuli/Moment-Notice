//
//  futureEventsTableViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "futureEventsTableViewController.h"

@interface futureEventsTableViewController ()
@property MNEventList* eventList;
@end

@implementation futureEventsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)unwindFromAddEvent:(UIStoryboardSegue*)sender
{
    
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
