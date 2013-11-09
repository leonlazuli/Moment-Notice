//
//  eventEditViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/8/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "eventEditViewController.h"

@interface eventEditViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fromDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *toDateTexeField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *completedLabel;

@end

@implementation eventEditViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender != self.saveButton)
        return;
    
    NSString* title = self.titleTextField.text;
    NSString* description = self.descriptionTextField.text;
    NSString* creatorID = self.user.userID;
    NSDate* fromdate = [self dateFromString:self.fromDateTextField.text];
    NSDate* todate = [self dateFromString:self.toDateTexeField.text];
    
    if([[NSDate date] compare:fromdate] == NSOrderedDescending ) // make sure the fromdate is later than current date
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"From date is earlier than current date, Edit failed"
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
                              message:@"From date is later than To date, Edit faild"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.event = [[MNEvent alloc] initReloadWithTitle:title detail:description fromDate:fromdate toDate:todate creatorID:creatorID creatDate:self.event.creatDate completed:self.event.completed passed:self.event.passed];
}

// to dismiss the keyboard when user click return  in the descriptionTextField
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
    [formatter setDateFormat:@"MMM-dd-yyyy HH:mm"];
    tempDate = [formatter stringFromDate:date];
    return tempDate;
}

- (NSDate*) dateFromString:(NSString*) string
{
    NSDate* tempDate = [[NSDate alloc] init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM-dd-yyyy HH:mm"];
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
    self.titleTextField.text = self.event.titile;
    self.fromDateTextField.text = [self.event stringOfFromDate];
    self.toDateTexeField.text = [self.event stringOfToDate];
    self.descriptionTextField.text = self.event.detail;
    if(self.event.completed)
        self.completedLabel.text = @"YES";
    else
        self.completedLabel.text = @"NO";
	// Do any additional setup after loading the view.
}



@end