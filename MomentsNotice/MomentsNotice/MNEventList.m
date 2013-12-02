//
//  MNEventList.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNEventList.h"
#import <Parse/Parse.h>

@interface MNEventList ()
@property NSMutableArray* eventlist; //of MNEvent
@end

@implementation MNEventList


-(NSUInteger) count
{
    return [self.eventlist count];
}

-(id) init
{
    self = [super init];
    self.eventlist = [[NSMutableArray alloc] init];
    return self;
    
}

-(id) WithUserFetchPastEvents:(MNUser*)user
{
    //you need user [NSDate date] to fech current time and compare them with the events the database to check whecher it is a pastevent or future event
    //use the userID to fetch the event from the database and add to eventlist
    //use the userID's pairedID to fetch the event from database
    
    //demo
    //self = [self init];
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
        
        if([[NSDate date] compare:fromdate1] == NSOrderedDescending )
        {
            if([fromdate1 compare:todate] == NSOrderedAscending )
            {
                [self.eventlist addObject:event];
            }

        }
    }
    

   // [self.eventlist addObject:event1];
    return self;
    //demo
    
}



-(id) WithUserFetchFutureEvents:(MNUser *)user
{
    //you need user [NSDate date] to fech current time and compare them with the events the database to check whecher it is a pastevent or future event
    
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
            [self.eventlist addObject:event];
            }
        }
    }

    //use the userID to fetch the event from the database and add to eventlist
    //use the userID's pairedID to fetch the event from database
    
    return self;
}

-(id) initWithUserFetchAllPastEvents:(MNUser*)user
{
    self = [self init];
    [self WithUserFetchPastEvents:user];
    if([user.pairedUserID isEqualToString:@""])
        return self;
    else
    {
        MNUser* pairedUser = [MNUser fetchUserByUserID:user.pairedUserID];
        [self WithUserFetchPastEvents:pairedUser];
    }
    [self sortByTime];
    return self;

    
}

-(id) initWithUserFetchAllFutureEvents:(MNUser *)user
{
    self = [self init];
    [self WithUserFetchFutureEvents:user];
    if([user.pairedUserID isEqualToString:@""])
        return self;
    else
    {
        MNUser* pairedUser = [MNUser fetchUserByUserID:user.pairedUserID];
        [self WithUserFetchFutureEvents:pairedUser];
    }
    [self sortByTime];
    return self;
}
-(MNEvent*) fectchEventByIndex:(int) index
{
    
    MNEvent* event = [[MNEvent alloc] init];
    event = self.eventlist[index];
    

    return event;
}

//-(MNEvent*) fectchEventByCreatorID:(NSString*)creatorID
//                     andCreateDate:(NSDate*)createDate;
-(void)sortByTime
{
    for(int i=0;i<self.eventlist.count;i++)
    {
        MNEvent *event=self.eventlist[i];
        for(int j=i+1;j<self.eventlist.count;j++)
        {
            MNEvent *event1=self.eventlist[j];
            if([event.fromDate compare:event1.fromDate ]== NSOrderedDescending)
                {
                    MNEvent *tempevent=self.eventlist[i];
                    self.eventlist[i]=self.eventlist[j];
                    self.eventlist[j]=tempevent;
                    
                }
                
        }
    }
    
    
}
-(MNEvent*) findLatestEvent
{
    
    MNEvent* event = [[MNEvent alloc] init];
    event = self.eventlist[0];
    
    
    return event;
}


-(void)addEvent:(MNEvent*)event;
{
    [self.eventlist addObject:event];
    PFObject *event1 = [PFObject objectWithClassName:@"Event"];
    [event1 setObject:event.title forKey:@"title"];
    [event1 setObject:event.detail forKey:@"detail" ];
    [event1 setObject:event.creatorID forKey:@"creator"];
    [event1 setObject:event.fromDate forKey:@"fromDate" ];
    [event1 setObject:event.toDate forKey:@"toDate" ];
   // NSDate* createdate = [NSDate date];
    //NSDate* fromdate = [createdate addTimeInterval:300];
    [event1 setObject:event.creatDate forKey:@"createDate"];
    
    [event1 saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //[hud hide:YES];
        
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            // Notify table view to reload the recipes from Parse cloud
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            
            // Dismiss the controller
          //  [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];

    // add this event to the database
}

-(void)deleteEventByIndex:(int)index;
{
    MNEvent* event=self.eventlist[index];
    [self.eventlist removeObjectAtIndex:index];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"createDate" equalTo:event.creatDate];
    PFObject *object = [query getFirstObject];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //[hud hide:YES];
        
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully deleted the event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            // Notify table view to reload the recipes from Parse cloud
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            
            // Dismiss the controller
            //  [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];


    //delete this event to the database
}


//-(void)deleteEventByCreatorID:(NSString*)creatorID
//               andcreateDate:(NSDate*)createDate;

-(void)editEventByIndex:(int)index
              withEvent:(MNEvent*)event
{
    [self.eventlist replaceObjectAtIndex:index withObject:event];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"creator" equalTo:event.creatorID];
    [query whereKey:@"createDate" equalTo:event.creatDate];
    


    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        [object setObject:event.title forKey:@"title"];
        [object setObject:event.detail forKey:@"detail" ];
        [object setObject:event.creatorID forKey:@"creator"];
        [object setObject:event.fromDate forKey:@"fromDate" ];
        [object setObject:event.toDate forKey:@"toDate" ];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //[hud hide:YES];
            
            if (!error) {
                // Show success message
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the event" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                // Notify table view to reload the recipes from Parse cloud
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
                
                // Dismiss the controller
                //[self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            
        }];
    }

}

@end
