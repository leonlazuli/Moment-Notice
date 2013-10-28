//
//  XYZAllEventsViewController.m
//  MomentNotice
//
//  Created by LiuLeon on 10/25/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

//Library
//
#import "XYZAllEventsViewController.h"
#import "XYZEventItem.h"
#import "XYZAddNewEventViewController.h"
#import "XYZEditEventViewController.h"

//Database Definition
//
#define DBNAME    @"Moment.sqlite"

//Main Menu
//
@interface XYZAllEventsViewController ()

//Create Row View
//
@property NSMutableArray *EventItems;
@property int selectedRow;

@end

@implementation XYZAllEventsViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Source Controller = %@", [segue sourceViewController]);
    NSLog(@"Destination Controller = %@", [segue destinationViewController]);
    NSLog(@"Segue Identifier = %@", [segue identifier]);
    if([[segue identifier] isEqualToString:@"editEventSegue"])
    {
        NSLog(@"Segue Identifier = %@ is running", [segue identifier]);
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        XYZEditEventViewController *linkedInViewController = [[navigationController viewControllers] lastObject];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        self.selectedRow = indexPath.row;
        linkedInViewController.thisEventItem = self.EventItems[indexPath.row];
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
    self.EventItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    const int Len = 10;
    NSString *showItem = [[NSString alloc] init];
    //print it on the screen
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
    
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
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

-(IBAction)unwindToAllEventFromEdit:(UIStoryboardSegue*) segue
{
    XYZEditEventViewController *source = [segue sourceViewController];
    XYZEventItem *newEvent = source.thisEventItem;
    if(newEvent != Nil)
    {
        NSLog(@"\nselected %d\n",self.selectedRow);
        [self.EventItems replaceObjectAtIndex:self.selectedRow withObject:newEvent];
        [self.tableView beginUpdates];
        [self.tableView reloadData];
        [self.tableView endUpdates];
        //        [self.EventItems addObject:newEvent];
        //        [self.tableView reloadData];
    }
}
-(void)loadInitialData
{
    self.EventItems = [[NSMutableArray alloc] init];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *dbPath = [documents stringByAppendingPathComponent:DBNAME];
    
    BOOL success = [fileMgr fileExistsAtPath:dbPath];
    if(!success)
    {
        NSLog(@"Cannot locate database file '%@'.", dbPath);
    }
    if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
    {
        NSLog(@"An error has occured");
        
    }
    
    NSString *querySQL = [NSString stringWithFormat:
                          @"SELECT * FROM EVENTS"];
    const char *sql = [querySQL UTF8String];
    sqlite3_stmt *sqlStatement;//do the SQL query and stores the result
    
    if(sqlite3_prepare_v2(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
    {
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
        //get the data from the query result
            XYZEventItem * evt = [[XYZEventItem alloc] init];
            NSString *temp = [[NSString alloc] init];
            evt.eventName= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            evt.eventDetail= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];

            temp= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,3)];
            NSDate *getDateString = [[NSDate alloc] init];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
            getDateString = [formatter dateFromString:temp];
            evt.fromDate= getDateString;
            
            temp= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,4)];
            getDateString = [formatter dateFromString:temp];
            evt.toDate= getDateString;
            
            
            [self.EventItems addObject:evt];
        }
    }
    else //the same as the former
    {
        while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
            XYZEventItem * evt = [[XYZEventItem alloc] init];
            NSString *temp = [[NSString alloc] init];
            evt.eventName= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
            evt.eventDetail= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
            
            temp= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,3)];
            NSDate *getDateString = [[NSDate alloc] init];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
            getDateString = [formatter dateFromString:temp];
            evt.fromDate= getDateString;
            
            
            temp= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,4)];
            getDateString = [formatter dateFromString:temp];
            evt.toDate= getDateString;
            
            
            [self.EventItems addObject:evt];
        }

        
        
    }

    sqlite3_close(db);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XYZEventItem *tappedItem = self.EventItems[indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
}



@end
