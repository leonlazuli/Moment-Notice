//
//  XYZAllEventsViewController.m
//  MomentNotice
//
//  Created by LiuLeon on 10/25/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "XYZAllEventsViewController.h"
#import "XYZEventItem.h"
#import "XYZAddNewEventViewController.h"

@interface XYZAllEventsViewController ()

@property NSMutableArray *EventItems;

@end

@implementation XYZAllEventsViewController

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
    self.EventItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.EventItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    XYZEventItem *eventItem = self.EventItems[indexPath.row];
    
    //transform the formdate to string
    NSString *fromDate = [[NSString alloc] init];
    NSDateFormatter * df2 = [[NSDateFormatter alloc] init];
    [df2 setDateFormat:@"MMM-dd HH:mm a"];
    fromDate = [df2 stringFromDate: eventItem.fromDate];
    //combine the title with from date
    const int Len = 20;
    NSString *showItem = [[NSString alloc] init];
    if(eventItem.eventName.length < Len)
    {
        showItem = [[NSString alloc]
                    initWithFormat:@"%@... at %@", eventItem.eventName,
                    fromDate];
        cell.textLabel.text = showItem;
    }
    else
    {
        showItem = [[NSString alloc]
                    initWithFormat:@"%@... at %@", [eventItem.eventName substringToIndex:Len],
                    fromDate];
        cell.textLabel.text = showItem;
    }
    
    if(eventItem.completed)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellEditingStyleNone;
    return cell;
}

-(IBAction)unwindToAllEvents:(UIStoryboardSegue*) segue
{
    XYZAddNewEventViewController *source = [segue sourceViewController];
    XYZEventItem *newEvent = source.addEventItem;
    if(newEvent != Nil)
    {
        [self.EventItems addObject:newEvent];
        [self.tableView reloadData];
    }
}

-(void) loadInitialData
{
    XYZEventItem *item1 = [[XYZEventItem alloc] init];
    item1.eventName = @"lalallalla11111";
    [self.EventItems addObject:item1];
    XYZEventItem *item2 = [[XYZEventItem alloc] init];
    item2.eventName = @"lalallalla22222";
    [self.EventItems addObject:item2];
    XYZEventItem *item3 = [[XYZEventItem alloc] init];
    item3.eventName = @"lalallalla33333";
    [self.EventItems addObject:item3];
    XYZEventItem *item4 = [[XYZEventItem alloc] init];
    item4.eventName = @"lalallalla4444";
    [self.EventItems addObject:item4];
}

//-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    XYZEventItem *tappedItem = self.EventItems[indexPath.row];
//    tappedItem.completed = !tappedItem.completed;
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XYZEventItem *tappedItem = self.EventItems[indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

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
