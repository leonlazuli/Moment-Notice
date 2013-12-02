//
//  MNpastEventsTableViewController.h
//  MomentsNotice
//
//  Created by Hyuk on 11/27/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MNUser.h"
#import "MNEventList.h"

@interface MNpastEventsTableViewController : UITableViewController
@property (strong, nonatomic) MNUser* user;
@end
