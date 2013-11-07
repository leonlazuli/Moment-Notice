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

//the setter for user, and we also set the welcome lable in this setter
-(void) setUser:(MNUser *)user
{
    _user = user;
    NSString *welcomeStr = [[NSString alloc] initWithFormat:@"Welcome to MomentsNotice!  %@ ", _user.nickName ];
    self.welcomeLable.text = welcomeStr;
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
