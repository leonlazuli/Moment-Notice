//
//  primaryMainMenuViewController.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "primaryMainMenuViewController.h"

@interface primaryMainMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *welcomeLable;

@end

@implementation primaryMainMenuViewController

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

//the setter for user, and we also set the welcome lable in this setter
-(void) setUser:(MNUser *)user
{
    _user = user;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *welcomeStr = [[NSString alloc] initWithFormat:@"Welcome to MomentsNotice!  %@ ", self.user.nickName ];
    self.welcomeLable.text = welcomeStr;
	// Do any additional setup after loading the view.
}



@end
