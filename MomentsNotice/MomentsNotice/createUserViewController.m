//
//  createUserViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/22/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "createUserViewController.h"
#import "MNUser.h"

@interface createUserViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userIDTextfield;
//@property (weak, nonatomic) IBOutlet UILabel *userIDTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *nicknameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *addressTextfield;

@end

@implementation createUserViewController

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Keyboard dismissal function
- (void) touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
    [_userIDTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
    [_nicknameTextfield resignFirstResponder];
    [_phoneNumberTextfield resignFirstResponder];
    [_addressTextfield resignFirstResponder];
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.phoneNumberTextfield || textField == self.addressTextfield)
    {
        CGRect newFrame = self.view.frame;
        newFrame.origin.y = newFrame.origin.y-140;
        [self.view setFrame:newFrame];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phoneNumberTextfield || textField == self.addressTextfield)
    {
    CGRect newFrame = self.view.frame;
    newFrame.origin.y = newFrame.origin.y+140;
    [self.view setFrame:newFrame];
    }
}

- (IBAction)createNewUser:(id)sender
{
    NSLog(@"type is: %d", self.userType);
  
    [MNUser addUserWithUserID:self.userIDTextfield.text passwaord:self.passwordTextfield.text nikename:self.nicknameTextfield.text phoneNumber:self.phoneNumberTextfield.text address:self.addressTextfield.text userType:self.userType block1:NO block2:NO];
   // NSLog(@"usertype is : %d \n",self.userType);
    
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
    self.userIDTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
    self.nicknameTextfield.delegate = self;
    self.phoneNumberTextfield.delegate = self;
    self.addressTextfield.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
