//
//  assistantPeopleViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/25/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "assistantPeopleViewController.h"

@interface assistantPeopleViewController ()  <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pariedOrNotLable;
@property (weak, nonatomic) IBOutlet UILabel *pariedUserNameLable;
@property (weak, nonatomic) IBOutlet UILabel *pairedUserPhoneLable;
@property (weak, nonatomic) IBOutlet UILabel *pairedUserAddressLable;
@property (weak, nonatomic) IBOutlet UIButton *dispairButton;

@end

@implementation assistantPeopleViewController

//this method is to hide the textfield when the user type return
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)dispair:(id)sender
{
    id temp = [MNUser fetchUserByUserID:self.user.pairedUserID];
    if(temp == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"There is no paired user. Please try again."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    else
    {
        MNUser* pairedUser = (MNUser*) temp;
        [self.user pairNewAccountWithUserID:@""];
        [pairedUser pairNewAccountWithUserID:@""];
        [self reloadData];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"dispair"
                              message:@"Successful dispaired"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;

        
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
        self.pariedOrNotLable.text = @"You haven't paired with the primary account, please let the primary user to pair you.";
        self.pariedUserNameLable.text = @"";
        self.pairedUserAddressLable.text = @"";
        self.pairedUserPhoneLable.text = @"";
        [self.dispairButton setHidden:YES];

    }
    else
    {
        MNUser* pairedUser = [MNUser fetchUserByUserID:self.user.pairedUserID];
        self.pariedOrNotLable.text = @"Your assistant user";
        self.pariedUserNameLable.text = [[NSString alloc] initWithFormat:@"Name: %@",pairedUser.nickName];
        self.pairedUserAddressLable.text = [[NSString alloc] initWithFormat:@"Address: %@",pairedUser.address];
        self.pairedUserPhoneLable.text = [[NSString alloc] initWithFormat:@"Phone Number: %@",pairedUser.phoneNumber];
        [self.dispairButton setHidden:NO];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"username: %@\n",self.user.userID);
    [self reloadData ];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
