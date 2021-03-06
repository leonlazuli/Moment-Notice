//
//  eventAddViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/8/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "eventAddViewController.h"
#import <Parse/Parse.h>

@interface eventAddViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fromDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *toDateTexeField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation eventAddViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender != self.saveButton)
        return;
    
    NSString* title = self.titleTextField.text;
    NSString* description = self.descriptionTextField.text;
    NSString* creatorID = self.user.userID;
    NSDate* fromdate = [self dateFromString:self.fromDateTextField.text];
    NSDate* todate = [self dateFromString:self.toDateTexeField.text];
    NSDate* creatDate=[NSDate date];
    
    if([[NSDate date] compare:fromdate] == NSOrderedDescending ) // make sure the fromdate is later than current date
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"From date is earlier than Current Date"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if([fromdate compare:todate] == NSOrderedDescending ) // make sure the fromdate is later than current date
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"From Date is later than To Date"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
       

    // Hyuk's Implementation: Local notifications
    // Allow notification to pop up 1 min before the event's fromdate
    NSDate* tempFire = [[NSDate alloc] init];
    NSTimeInterval minutes5 = -60;
    tempFire = [fromdate dateByAddingTimeInterval:minutes5];
    
    //  Create notification (automatically stored into coredata)
    UILocalNotification* notif = [ [UILocalNotification alloc] init];
    notif.fireDate = tempFire;
    notif.alertBody = title;
    notif.alertAction = @"See Event";
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.soundName = UILocalNotificationDefaultSoundName;
    //  Create badges
    notif.applicationIconBadgeNumber = [[UIApplication sharedApplication]applicationIconBadgeNumber]+1;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject: title forKey:@"IDkey"];
    notif.userInfo = infoDict;
    
    //  Create the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    

    
    self.event = [[MNEvent alloc] initWithTitle:title detail:description fromDate:fromdate toDate:todate creatorID:creatorID creatDate:creatDate];
}

// to dismiss the keyboard when user click return  in the descriptionTextField
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

// Keyboard dismissal function
- (void) touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
    [_fromDateTextField resignFirstResponder];
    [_toDateTexeField resignFirstResponder];
    [_titleTextField resignFirstResponder];
    [_descriptionTextField resignFirstResponder];
    
}

//to dismiss the keyboard when user click return in a textfield
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//to dismiss the datepicker of fromDateDoneButton when user click the done button
- (IBAction)fromDateDoneButton:(UIButton *)sender
{
    [self.fromDateTextField resignFirstResponder];
}

//to dismiss the datepicker of toDateDoneButton when user click the done button
- (IBAction)toDateDoneButton:(id)sender
{
    [self.toDateTexeField resignFirstResponder];
}

// call a datepicker when user click the textfield of formdate or todate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.fromDateTextField)
    {
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateFromDateField:) forControlEvents:UIControlEventValueChanged];
    [self.fromDateTextField setInputView:datePicker];
    }
    
    if(textField == self.toDateTexeField)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateToDateField:) forControlEvents:UIControlEventValueChanged];
        [self.toDateTexeField setInputView:datePicker];
    }
}

-(void) textViewDidBeginEditing:(UITextField *)textField
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = newFrame.origin.y-165;
    [self.view setFrame:newFrame];
}

-(void) textViewDidEndEditing:(UITextField *)textField
{
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = newFrame.origin.y+165;
    [self.view setFrame:newFrame];
}

// Called when the date picker changes.
- (void)updateFromDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.fromDateTextField.inputView;
    self.fromDateTextField.text = [NSString stringWithFormat:@"%@",[self stringFromDate:picker.date]];
}

- (void)updateToDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.toDateTexeField.inputView;
    self.toDateTexeField.text = [NSString stringWithFormat:@"%@",[self stringFromDate:picker.date]];
}



- (NSString *)stringFromDate:(NSDate *)date
{
    NSString* tempDate = [[NSString alloc] init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    tempDate = [formatter stringFromDate:date];
    return tempDate;
}

- (NSDate*) dateFromString:(NSString*) string
{
    NSDate* tempDate = [[NSDate alloc] init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    tempDate = [formatter dateFromString:string];
    return tempDate;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fromDateTextField.delegate = self;
    self.toDateTexeField.delegate = self;
    self.titleTextField.delegate = self;
    self.descriptionTextField.delegate = self;
    self.titleTextField.text = self.user.userID;
	// Do any additional setup after loading the view.
}



@end
