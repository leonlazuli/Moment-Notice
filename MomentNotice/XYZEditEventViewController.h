//
//  XYZEditEventViewController.h
//  MomentNotice
//
//  Created by LiuLeon on 10/26/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//
/*
 
 Known Bugs:
 On-screen keyboard cannot be hidden
 Cannot edit start time
 Cannot delete or cancel events
 
 
 
 */

#import <UIKit/UIKit.h>
#include "XYZEventItem.h"
#import <sqlite3.h>


@interface XYZEditEventViewController : UIViewController
{
    sqlite3 *db;
}
@property XYZEventItem* thisEventItem;

@end
