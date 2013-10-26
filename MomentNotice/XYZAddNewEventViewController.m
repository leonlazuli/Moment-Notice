//
//  XYZAddNewEventViewController.m
//  MomentNotice
//
//  Created by LiuLeon on 10/25/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "XYZAddNewEventViewController.h"

@interface XYZAddNewEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *EventTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *fromDate;
@property (weak, nonatomic) IBOutlet UITextField *toDate;
@property (weak, nonatomic) IBOutlet UITextView *eventDetail;

@end

@implementation XYZAddNewEventViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender != self.doneButton)
        return;
    if(self.EventTitle.text.length > 0)
    {
        
        
        self.addEventItem = [[XYZEventItem alloc] init];
        self.addEventItem.eventName = self.EventTitle.text;
        self.addEventItem.completed = NO;
        self.addEventItem.eventDetail = self.eventDetail.text;
        // get current time
        NSString* tempDate;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-YYYY hh:mm"];
        tempDate = [formatter stringFromDate:[NSDate date]];
        //        NSLog(@"sfsdf %@",date);
        
        // NSDateFormatter * df2 = [[NSDateFormatter alloc] init];
        //[df2 setDateFormat:@"MMM-dd-YYYY HH:mm a"];
        //tempDate = [df2 stringFromDate:getDate];
        
        //get current time
        
        // notice that getDatestring is nil if the format is fualt  $$$$$$$$
        NSString *fromDateString = [[NSString alloc] initWithString:self.fromDate.text];
        NSString *toDateString = [[NSString alloc] initWithString:self.toDate.text];
        NSDate *getDateString = [[NSDate alloc] init];
        getDateString = [formatter dateFromString:fromDateString];
        self.addEventItem.fromDate = getDateString;
        getDateString = [formatter dateFromString:toDateString];
        self.addEventItem.toDate = getDateString;
        
        
        NSDateFormatter * df2 = [[NSDateFormatter alloc] init];
        [df2 setDateFormat:@"MMM-dd-YYYY HH:mm a"];
        tempDate = [df2 stringFromDate:getDateString];
        NSLog(@"系统sdfsdf当前时间为：%@",tempDate);
        
        
        
      
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
