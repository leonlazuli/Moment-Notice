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

-(id) initWithUserFetchPastEvents:(MNUser*)user
{
    //you need user [NSDate date] to fech current time and compare them with the events the database to check whecher it is a pastevent or future event
    //use the userID to fetch the event from the database and add to eventlist
    //use the userID's pairedID to fetch the event from database
    
    //demo
    self = [self init];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"creator" equalTo:user.userID];
    NSArray *objects=[query findObjects];
    for (PFObject *object in objects) {
        NSDate* fromdate1= [object objectForKey:@"fromDate"];
        NSDate* todate = [object objectForKey:@"toDate"];
        NSDate* creatDate = [object objectForKey:@"createDate"];
        NSString *temp=[object objectForKey:@"title"];
        MNEvent* event = [[MNEvent alloc] initWithTitle:temp detail:@"" fromDate:fromdate1 toDate:todate creatorID:user.userID creatDate:creatDate];
        [self.eventlist addObject:event];
    }

   // [self.eventlist addObject:event1];
    return self;
    //demo
    
}


-(id) initWithUserFetchFutureEvents:(MNUser *)user
{
    //you need user [NSDate date] to fech current time and compare them with the events the database to check whecher it is a pastevent or future event
    self = [self init];
    //use the userID to fetch the event from the database and add to eventlist
    //use the userID's pairedID to fetch the event from database
    
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

-(void)addEvent:(MNEvent*)event;
{
    [self.eventlist addObject:event];
    PFObject *event1 = [PFObject objectWithClassName:@"Event"];
    [event1 setObject:event.title forKey:@"title"];
    [event1 setObject:event.description forKey:@"detail" ];
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
   // PFObject *event1 = [PFObject objectWithClassName:@"Event"];
    //[event1 setObject:event.title forKey:@"title"];
    //NSDate* createdate = [NSDate date];
    //NSDate* fromdate = [createdate addTimeInterval:300];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"creator" equalTo:event.creatorID];
    [query whereKey:@"createDate" equalTo:event.creatDate];
    


    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        [object setObject:event.title forKey:@"title"];
        [object setObject:event.description forKey:@"detail" ];
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
