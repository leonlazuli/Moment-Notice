//
//  PrimaryLoginViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "PrimaryLoginViewController.h"
#import "primaryMainMenuViewController.h"
#import "createUserViewController.h"


@interface PrimaryLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextfield;


@end

@implementation PrimaryLoginViewController

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Keyboard dismissal function
- (void) touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
    [_userNameTextField resignFirstResponder];
    [_userPasswordTextfield resignFirstResponder];

    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"primaryLogin"])
    {
        if(!self.logInUser) // make sure the logInUser is not nil
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"LogIn user hasn't been initialized"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if(!self.logInUser.userID) // make sure the loginUser has been assigned with value
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"LogIn User hasn't been assigned a value "
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            return;
        }

        if([segue.destinationViewController isKindOfClass:[primaryMainMenuViewController class]])
        {
            primaryMainMenuViewController *menuVC = segue.destinationViewController;
            menuVC.user = self.logInUser;
        }
        
    }
    else if([[segue identifier] isEqualToString:@"primaryLoginToCreateUser"])
    {
        createUserViewController* createVC = segue.destinationViewController;
        createVC.userType = PRIMARY_USER;
    }

}

- (IBAction)logInButton:(id)sender  //??? when click the login button
{
    //demo
    //get the username and pin from database, if match performsegue, or give user some alert.
    id tempUser = [MNUser checkUserID:self.userNameTextField.text password:self.userPasswordTextfield.text];
    if(tempUser != nil)
    {
        // get the information of that user from database
        
        // then init the logInUer
        
        self.logInUser = (MNUser*)tempUser;
        if(self.logInUser.userType == ASSISTANT_USER)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"You are not a primary user"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
        }
        else
            [self performSegueWithIdentifier:@"primaryLogin" sender:self];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"Your user ID or password is invalid"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    }
    //demo
}

- (void)viewDidLoad // ??? you can do the auto username/password fullfill here 
{
    [super viewDidLoad];
    self.userNameTextField.delegate = self;
    self.userPasswordTextfield.delegate = self;
    //???
	// Do any additional setup after loading the view.
}



@end
