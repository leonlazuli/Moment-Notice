//
//  PrimaryLoginViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "PrimaryLoginViewController.h"
#import "primaryMainMenuViewController.h"


@interface PrimaryLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;


@end

@implementation PrimaryLoginViewController

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"primaryLogin"])
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

        if([segue.destinationViewController isKindOfClass:[primaryMainMenuViewController class]])
        {
            primaryMainMenuViewController *menuVC = segue.destinationViewController;
            menuVC.user = self.logInUser;
        }
        
    }
}

- (IBAction)logInButton:(id)sender  //??? when click the login button
{
    //demo
    //get the username and pin from database, if match performsegue, or give user some alert.
    if([self.userNameTextField.text isEqualToString:@"leon"])
    {
        // get the information of that user from database
        
        // then init the logInUer
        MNUser* tempuser = [[MNUser alloc ] initWithUserID:@"leon" password:@"123456" nakename:@"leonLiu" usertype:PRIMARY_USER pairedUser:@"chen" block1:NO blicK2:NO];
        self.logInUser = tempuser;
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
    //???
	// Do any additional setup after loading the view.
}



@end
