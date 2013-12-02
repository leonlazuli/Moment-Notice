//
//  MNEvent.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNEvent.h"
#import "MNUser.h"
#import <Parse/Parse.h>


@implementation MNEvent
-(id) initWithTitle:(NSString*)title
               detail:(NSString*)detail
             fromDate:(NSDate*)fromdate
               toDate:(NSDate*)todate
            creatorID:(NSString*)creatorid
            creatDate:(NSDate *)creatdate
{
    self = [self init];
    self.title = title;
    self.detail = detail;
    self.fromDate = fromdate;
    self.toDate = todate;
    self.creatorID = creatorid;
    self.creatDate = creatdate;
    self.completed = NO;
    self.passed = NO;
    return self;
    
}

//for reloading events from database
-(id) initReloadWithTitle:(NSString*)title
                 detail:(NSString*)detail
               fromDate:(NSDate*)fromdate
                 toDate:(NSDate*)todate
              creatorID:(NSString*)creatorid
              creatDate:(NSDate*)creatdate
              completed:(BOOL)c
{
    self = [self init];
    self.title = title;
    self.detail = detail;
    self.fromDate = fromdate;
    self.toDate = todate;
    self.creatorID = creatorid;
    self.creatDate = creatdate;
    self.completed = c;
    return self;
    
}

//generic funtion to transform date to a string 
-(NSString*) stringOfDate:(NSDate*)date
{
    NSString* tempDate = [[NSString alloc] init];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    tempDate = [formatter stringFromDate:date];
    return tempDate;
}

+(MNEvent*) findLatestEvent:(MNUser*)user
{
    NSMutableArray* eventlist=[[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"creator" equalTo:user.userID];
    NSArray *objects=[query findObjects];
    for (PFObject *object in objects) {
        NSDate* fromdate1= [object objectForKey:@"fromDate"];
        NSDate* todate = [object objectForKey:@"toDate"];
        NSDate* creatDate = [object objectForKey:@"createDate"];
        NSString *temp=[object objectForKey:@"title"];
        NSString *detail=[object objectForKey:@"detail"];
        NSNumber *temp2=[object objectForKey:@"completed"];
        BOOL completed=[temp2 boolValue];
        MNEvent *event =[[MNEvent alloc] initReloadWithTitle:temp detail:detail fromDate:fromdate1 toDate:todate creatorID:user.userID creatDate:creatDate completed:completed ];
        if([[NSDate date] compare:fromdate1] == NSOrderedAscending )
        {
            if([fromdate1 compare:todate] == NSOrderedAscending )
            {
                [eventlist addObject:event];
            }
        }
    }
    [query whereKey:@"creator" equalTo:user.pairedUserID];
    NSArray *objects1=[query findObjects];
    for (PFObject *object in objects1) {
        NSDate* fromdate1= [object objectForKey:@"fromDate"];
        NSDate* todate = [object objectForKey:@"toDate"];
        NSDate* creatDate = [object objectForKey:@"createDate"];
        NSString *temp=[object objectForKey:@"title"];
        NSString *detail=[object objectForKey:@"detail"];
        NSNumber *temp2=[object objectForKey:@"completed"];
        BOOL completed=[temp2 boolValue];
        MNEvent *event =[[MNEvent alloc] initReloadWithTitle:temp detail:detail fromDate:fromdate1 toDate:todate creatorID:user.userID creatDate:creatDate completed:completed ];
        if([[NSDate date] compare:fromdate1] == NSOrderedAscending )
        {
            if([fromdate1 compare:todate] == NSOrderedAscending )
            {
                [eventlist addObject:event];
            }
        }
    }
    for(int i=0;i<eventlist.count;i++)
    {
        MNEvent *event=eventlist[i];
        for(int j=i+1;j<eventlist.count;j++)
        {
            MNEvent *event1=eventlist[j];
            if([event.fromDate compare:event1.fromDate ]== NSOrderedDescending)
            {
                MNEvent *tempevent=eventlist[i];
                eventlist[i]=eventlist[j];
                eventlist[j]=tempevent;
                
            }
            
        }
    }
    return eventlist[0];
    
}
     

-(NSString*) stringOfFromDate
{
    return [self stringOfDate:self.fromDate];
}

-(NSString*) stringOfToDate
{
    return [self stringOfDate:self.toDate];
}
-(NSString*) stringOfCreatDate
{
    return [self stringOfDate:self.creatDate];
}
-(void) syncEventData:(MNEvent*)event
{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"creator" equalTo:event.creatorID];
    [query whereKey:@"createDate" equalTo:event.creatDate];
    PFObject *object = [query getFirstObject];
    [object setObject:event.title forKey:@"title"];
    [object setObject:event.detail forKey:@"detail" ];
    [object setObject:event.creatorID forKey:@"creator"];
    [object setObject:event.fromDate forKey:@"fromDate" ];
    [object setObject:event.toDate forKey:@"toDate" ];
    [object setObject:[NSNumber numberWithBool:event.completed] forKey:@"completed"];
    [object saveInBackground];
    
    //use userID to find the user in database and sync it;
}

@end







































































