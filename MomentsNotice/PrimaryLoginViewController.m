//
//  PrimaryLoginViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "PrimaryLoginViewController.h"

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
    //???
}

- (IBAction)logInButton:(id)sender  //??? when click the login button
{
    //demo
    //get the username and pin from database, if match performsegue, or give user some alert.
    if([self.userNameTextField.text isEqualToString:@"leon"])
    {
        // get the information of that user
        
        // then init the logInUer
        [self.logInUser initWithUserID:@"leon" password:@"123456" nakename:@"leonLiu" usertype:PRIMARY_USER pairedUser:@"chen" block1:NO blicK2:NO];
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
