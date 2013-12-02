//
//  MNdataAnalysisViewController.m
//  MomentsNotice
//
//  Created by Hyuk on 11/27/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNdataAnalysisViewController.h"
#import "primaryMainMenuViewController.h"
#import "assistantMainMenuViewController.h"
#import "eventAddViewController.h"
#import "eventEditViewController.h"

@interface MNdataAnalysisViewController ()
@property MNEventList* eventList;
@property (weak, nonatomic) IBOutlet UITextField *eventsLabel;
@property (weak, nonatomic) IBOutlet UITextField *rememberedLabel;
@property (weak, nonatomic) IBOutlet UITextField *mostSuccessLabel;
@property (weak, nonatomic) IBOutlet UITextField *leastSuccessLabel;

@end

@implementation MNdataAnalysisViewController

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

    int count = 0;
    int remembered = 0;
    int hour;
    int hours[8];
    for (int i=0; i < 8; i++)
        hours[i] = 0;
    
    NSString *tester = [[NSString alloc] init];
    self.eventList = [[MNEventList alloc] initWithUserFetchAllPastEvents:self.user];
    MNEvent *temp = [[MNEvent alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH"];
    
    for (NSInteger i = 1 ; i <  self.eventList.count; i++)
    {
        temp = [self.eventList fectchEventByIndex:i];
        if (temp.completed)
        {
            remembered++;
            tester = @"A Completed exists!";
    
            hour = [[dateFormatter stringFromDate: temp.fromDate] intValue];

            if (0 <= hour && hour < 3)
            {
                hours[0]++;
            }
            else if (3 <= hour && hour < 6)
            {
                hours[1]++;
            }
            else if (6 <= hour && hour < 9)
            {
                hours[2]++;
            }
            else if (9 <= hour && hour < 12)
            {
                hours[3]++;
            }
            else if (12 <= hour && hour < 15)
            {
                hours[4]++;
            }
            else if (15 <= hour && hour < 18)
            {
                hours[5]++;
            }
            else if (18 <= hour && hour < 21)
            {
                hours[6]++;
            }
            else if (21 <= hour && hour < 24)
            {
                hours[7]++;
            }
        }
        count++;
    }
    
    self.eventsLabel.text = [NSString stringWithFormat:@"%d",  count];
    double percent = remembered;
    
    if (count == 0)
        percent = 0;
    else
        percent = 100*remembered/count;
    
    self.rememberedLabel.text = [NSString stringWithFormat:@"%d/%d (%.0f %%)", remembered, count, percent];
   // self.rememberedLabel.text = tester;
    int max = hours[0];
    int maxIndex = 0;
    int minIndex = 0;
    int min = hours[0];
    for ( int i=1; i<8; i++)
    {
        if (max < hours[i])
        {
            maxIndex = i;
        }
        if (min > hours[i])
        {
            minIndex = i;
        }
    }
    
    self.mostSuccessLabel.text = [NSString stringWithFormat:@"%d:00 to %d:00", 3*maxIndex, 3*(maxIndex+1)];
    self.leastSuccessLabel.text = [NSString stringWithFormat:@"%d:00 to %d:00", 3*minIndex, 3*(minIndex+1)];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
