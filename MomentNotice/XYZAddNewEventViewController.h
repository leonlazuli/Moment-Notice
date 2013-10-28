//
//  XYZAddNewEventViewController.h
//  MomentNotice
//
//  Created by LiuLeon on 10/25/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//
/*
 
 Known Bugs:
 On-screen keyboard cannot be hidden
 Event was not saved to database properly(fixed)
 Field entries were not saved at the corrent type(fixed)
 Event start time was fixed to present time(fixed)
 
 
 */
#import <UIKit/UIKit.h>
#import "XYZEventItem.h"
#import <sqlite3.h>


@interface XYZAddNewEventViewController : UIViewController
{
    sqlite3 *db;
}

@property XYZEventItem* addEventItem;

@end

