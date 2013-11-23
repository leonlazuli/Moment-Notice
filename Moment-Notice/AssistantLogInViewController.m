//
//  AssistantLogInViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "AssistantLogInViewController.h"
#import "assistantMainMenuViewController.h"
#import "createUserViewController.h"

@interface AssistantLogInViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextfield;


@end

@implementation AssistantLogInViewController

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"assistantLoginToMenu"])
    {
        if(!self.logInUser) // make sure the logInUser is not nil
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"logIn user hasn't been initialed"
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
                                  message:@"logInUser hasn't been assigned value "
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if([segue.destinationViewController isKindOfClass:[assistantMainMenuViewController class]])
        {
            assistantMainMenuViewController *menuVC = segue.destinationViewController;
            menuVC.user = self.logInUser;
        }
        
    }
    else if([[segue identifier] isEqualToString:@"assistantLoginToCreateUser"])
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
        [self performSegueWithIdentifier:@"assistantLoginToMenu" sender:self];
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
