//
//  LogInViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController () <UITextFieldDelegate>


@end

@implementation LogInViewController 

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)unwindFromPrimaryMenuToLogin:(UIStoryboardSegue*)sender
{
    
}

-(MNUser*) logInUser  // setter of propertyy logInUser
{
    if(!_logInUser)
    _logInUser = [[MNUser alloc] init];
    return _logInUser;
    
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
