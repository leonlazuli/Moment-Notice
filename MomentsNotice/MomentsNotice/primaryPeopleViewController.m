//
//  primaryPeopleViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/22/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "primaryPeopleViewController.h"

@interface primaryPeopleViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pariedOrNotLable;
@property (weak, nonatomic) IBOutlet UILabel *pariedUserNameLable;
@property (weak, nonatomic) IBOutlet UILabel *pairedUserPhoneLable;
@property (weak, nonatomic) IBOutlet UILabel *pairedUserAddressLable;
@property (weak, nonatomic) IBOutlet UIButton *pairButton;
@property (weak, nonatomic) IBOutlet UILabel *pairedLable;
@property (weak, nonatomic) IBOutlet UITextField *pairedUserIDTextfield;

@end

@implementation primaryPeopleViewController

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Keyboard dismissal function
- (void) touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
    [_pairedUserIDTextfield resignFirstResponder];
    
}

- (IBAction)pair:(id)sender
{
    id temp = [MNUser fetchUserByUserID:self.pairedUserIDTextfield.text];
    if(temp == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"There is no such user. Please try again."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;

    }
    else
    {
        MNUser* pairedUser = (MNUser*) temp;
        if(pairedUser.userType != ASSISTANT_USER)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"This user is not an assistant user. Please try again."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        else
        {
            [self.user pairNewAccountWithUserID:self.pairedUserIDTextfield.text];
            [pairedUser pairNewAccountWithUserID:self.user.userID];
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Success"
                                  message:[[NSString alloc] initWithFormat:@"You are paired with %@ Now!",pairedUser.nickName]
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [self reloadData];


        }
        
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

-(void)reloadData
{
    if([self.user.pairedUserID isEqualToString:@""])
    {
        self.pariedOrNotLable.text = @"You haven't paired with the assistant account, please press the Pair button to pair one";
        self.pariedUserNameLable.text = @"";
        self.pairedUserAddressLable.text = @"";
        self.pairedUserPhoneLable.text = @"";
        [self.pairButton setHidden:NO];
        [self.pairedUserIDTextfield setHidden:NO];
        [self.pairedLable setHidden:NO];
        //[self.pairButton setTitle:@"pairrr" forState:UIControlStateNormal];
        //[self.pairButton setEnabled:YES];
    }
    else
    {
        MNUser* pairedUser = [MNUser fetchUserByUserID:self.user.pairedUserID];
        self.pariedOrNotLable.text = @"Your assistant user";
        self.pariedUserNameLable.text = [[NSString alloc] initWithFormat:@"Name: %@",pairedUser.nickName];
        self.pairedUserAddressLable.text = [[NSString alloc] initWithFormat:@"Address: %@",pairedUser.address];
        self.pairedUserPhoneLable.text = [[NSString alloc] initWithFormat:@"Phone Number: %@",pairedUser.phoneNumber];
        [self.pairButton setHidden:YES];
        [self.pairedUserIDTextfield setHidden:YES];
        [self.pairedLable setHidden:YES];
        
    }
}

- (void)viewDidLoad
{
    self.pairedUserIDTextfield.delegate = self;
    [super viewDidLoad];
    [self reloadData ];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
