//
//  MNEvent.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//
#import "MNEvent.h"

@implementation MNEvent
<<<<<<< HEAD

-(id) init
{
    self = [super init];
    self.title = [[NSString alloc] init];
    self.detail = [[NSString alloc] init];
    self.fromDate = [[NSDate alloc] init];
    self.toDate = [[NSDate alloc] init];
    self.creatorID = [[NSString alloc] init];
    self.creatDate = [NSDate date];
    return self;
    
    
}

-(id) initWithTitle:(NSString*)title
             detail:(NSString*)detail
           fromDate:(NSDate*)fromdate
             toDate:(NSDate*)todate
          creatorID:(NSString*)creatorid
{
    self = [self init];
    self.title = title;
=======
-(id) initWithTitle:(NSString*)titile
               detail:(NSString*)detail
             fromDate:(NSDate*)fromdate
               toDate:(NSDate*)todate
            creatorID:(NSString*)creatorid
{
    self = [self init];
    self.titile = titile;
>>>>>>> d63db7468cf21714840a47bd1f67bd23958c4f62
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
<<<<<<< HEAD
-(id) initReloadWithTitle:(NSString*)title
                   detail:(NSString*)detail
                 fromDate:(NSDate*)fromdate
                   toDate:(NSDate*)todate
                creatorID:(NSString*)creatorid
                creatDate:(NSDate*)creatdate
                completed:(BOOL)c
                   passed:(BOOL)p
{
    self = [self init];
    self.title = title;
=======
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
>>>>>>> d63db7468cf21714840a47bd1f67bd23958c4f62
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























































































