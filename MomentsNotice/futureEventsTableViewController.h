//
//  futureEventsTableViewController.h
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNUser.h"
#import "MNEventList.h"

@interface futureEventsTableViewController : UITableViewController
@property (strong, nonatomic) MNUser* user;
@end
