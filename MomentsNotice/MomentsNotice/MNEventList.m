//
//  MNEventList.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNEventList.h"

@interface MNEventList ()
@property NSMutableArray* eventlist; //of MNEvent
@end

@implementation MNEventList
-(void) initWithUserFetchPastEvents:(MNUser*)user
{
    //you need user [NSDate date] to fech current time and compare them with the events the database to check whecher it is a pastevent or future event
    
    [self init];
    //use the userID to fetch the event from the database and add to eventlist
    //use the userID's pairedID to fetch the event from database
    
}

-(void) initWithUserFetchFutureEvents:(MNUser *)user
{
    //you need user [NSDate date] to fech current time and compare them with the events the database to check whecher it is a pastevent or future event
    [self init];
    //use the userID to fetch the event from the database and add to eventlist
    //use the userID's pairedID to fetch the event from database
}

-(MNEvent*) fectchEventByIndex:(int) index
{
    MNEvent* event = [[MNEvent alloc] init];
    event = self.eventlist[index];
    return event;
}

//-(MNEvent*) fectchEventByCreatorID:(NSString*)creatorID
//                     andCreateDate:(NSDate*)createDate;

-(void)addEvent:(MNEvent*)event;
{
    [self.eventlist addObject:event];
    // add this event to the database
}

-(void)deleteEventByIndex:(int)index;
{
    [self.eventlist removeObjectAtIndex:index];
    //delete this event to the database
}


//-(void)deleteEventByCreatorID:(NSString*)creatorID
//               andcreateDate:(NSDate*)createDate;

-(void)editEventByIndex:(int)index
              withEvent:(MNEvent*)event
{
    [self.eventlist replaceObjectAtIndex:index withObject:event];
    // update this event in the database
}

@end
