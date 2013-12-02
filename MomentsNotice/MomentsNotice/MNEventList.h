//
//  MNEventList.h
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MNEvent.h"
#import "MNUser.h"

@interface MNEventList: NSObject

-(id) initWithUserFetchAllPastEvents:(MNUser*)user;
-(id) initWithUserFetchAllFutureEvents:(MNUser *)user;
-(NSUInteger) count;

-(MNEvent*) fectchEventByIndex:(int) index;


//-(MNEvent*) fectchEventByCreatorID:(NSString*)creatorID
//                     andCreateDate:(NSDate*)createDate;

-(void)addEvent:(MNEvent*)Event;
-(void)deleteEventByIndex:(int)index;


//-(void)deleteEventByCreatorID:(NSString*)creatorID
//               andcreateDate:(NSDate*)createDate;

-(void)editEventByIndex:(int)index
              withEvent:(MNEvent*)event;
-(void)sortByTime;
-(MNEvent*) findLatestEvent;
@end
