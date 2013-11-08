//
//  MNEvent.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNEvent.h"

@implementation MNEvent
-(id) initWithTitle:(NSString*)titile
               detail:(NSString*)detail
             fromDate:(NSDate*)fromdate
               toDate:(NSDate*)todate
            creatorID:(NSString*)creatorid
{
    self = [self init];
    self.titile = titile;
    self.detail = detail;
    self.fromDate = fromdate;
    self.toDate = todate;
    self.creatorID = creatorid;
    self.creatDate = [NSDate date];
    self.completed = NO;
    self.passed = NO;
    return self;
    
}

//for reloading events from database
-(id) initReloadWithTitle:(NSString*)titile
                 detail:(NSString*)detail
               fromDate:(NSDate*)fromdate
                 toDate:(NSDate*)todate
              creatorID:(NSString*)creatorid
              creatDate:(NSDate*)creatdate
              completed:(BOOL)c
                 passed:(BOOL)p
{
    self = [self init];
    self.titile = titile;
    self.detail = detail;
    self.fromDate = fromdate;
    self.toDate = todate;
    self.creatorID = creatorid;
    self.creatDate = creatdate;
    self.completed = c;
    self.passed = p;
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
@end







































































