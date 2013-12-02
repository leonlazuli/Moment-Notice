//
//  eventEditViewController.h
//  MomentsNotice
//
//  Created by LiuLeon on 11/8/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNUser.h"
#import "MNEvent.h"


@interface eventEditViewController : UIViewController

@property MNEvent* event;
@property MNUser*  user;

@end
