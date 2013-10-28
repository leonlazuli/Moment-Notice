//
//  XYZEditEventViewController.m
//  MomentNotice
//
//  Created by LiuLeon on 10/26/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "XYZEditEventViewController.h"

#define DBNAME    @"Moment.sqlite"
#define TITLE      @"title"
#define EVENTDETAIL     @"eventdetail"
#define FROMDATE   @"fromdate"
#define TODATE     @"todate"
#define TABLENAME @"EVENTS"


@interface XYZEditEventViewController () //these variable gets from storyboard, which shows the edit function

@property (weak, nonatomic) IBOutlet UITextField *EventTitle;
@property (weak, nonatomic) IBOutlet UITextField *fromDate;
@property (weak, nonatomic) IBOutlet UITextField *toDate;
@property (weak, nonatomic) IBOutlet UITextView *Completed;
@property (weak, nonatomic) IBOutlet UITextView *eventDetail;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation XYZEditEventViewController

//prepare for the Segue. Pass data from This editEventController to allEventController
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //The the segue is not activated by save button, then just return
    if(sender != self.saveButton)
        return;
    //else if the EventTitle has been inputed then update the data of that Item in database
    if(self.EventTitle.text.length > 0)
    {
        
         //all the data is uodated
        self.thisEventItem = [[XYZEventItem alloc] init];
        self.thisEventItem.eventName = self.EventTitle.text;
        self.thisEventItem.eventDetail = self.eventDetail.text;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
        NSDate *getDateString = [[NSDate alloc] init];
        getDateString = [formatter dateFromString:self.fromDate.text];
        self.thisEventItem.fromDate = getDateString;
        getDateString = [formatter dateFromString:self.toDate.text];
        self.thisEventItem.toDate = getDateString;
        //open the database
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documents = [paths objectAtIndex:0];
        NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
        if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"open fails");
        }
     
       //update the database
        NSString *sql2 = [NSString stringWithFormat:
                              @"UPDATE '%@' SET '%@'='%@','%@'='%@','%@'='%@','%@'='%@' WHERE FROMDATE='%@';",
                              TABLENAME, TITLE,self.EventTitle.text,EVENTDETAIL,self.eventDetail.text,FROMDATE,self.fromDate.text,TODATE,self.toDate.text,self.fromDate.text];
        [self execSql:sql2];
        sqlite3_close(db);
        
  
        
    }
    
}
-(void)execSql:(NSString *)sql //execute the SQL sentence
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"fails operating data");
    }
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad //this method means that first in the view, there exists the data stores got from database(users created before)
{
    [super viewDidLoad];
	self.EventTitle.text = self.thisEventItem.eventName;
    self.eventDetail.text = self.thisEventItem.eventDetail;
    NSString* tempDate = [[NSString alloc] init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];//translate the format(string in database to date format)
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    tempDate = [formatter stringFromDate:self.thisEventItem.fromDate];
    self.fromDate.text = tempDate;

	tempDate = [formatter stringFromDate:self.thisEventItem.toDate];
    self.toDate.text = tempDate;
    if(self.thisEventItem.completed ==YES)
        self.Completed.text = @"YES";
    else
        self.Completed.text = @"NO";
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
