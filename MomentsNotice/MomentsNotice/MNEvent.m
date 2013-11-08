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
-(void) initWithTitle:(NSString*)title
=======

-(id) init
{
    self = [super init];
    self.titile = [[NSString alloc] init];
    self.detail = [[NSString alloc] init];
    self.fromDate = [[NSDate alloc] init];
    self.toDate = [[NSDate alloc] init];
    self.creatorID = [[NSString alloc] init];
    self.creatDate = [NSDate date];
    return self;
    
    
}

-(id) initWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
               detail:(NSString*)detail
             fromDate:(NSDate*)fromdate
               toDate:(NSDate*)todate
            creatorID:(NSString*)creatorid
{
<<<<<<< HEAD
    [self init];
    self.title = title;
=======
    self = [self init];
    self.titile = titile;
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
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
-(void) reloadWithTitle:(NSString*)title
=======
-(id) initReloadWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
                 detail:(NSString*)detail
               fromDate:(NSDate*)fromdate
                 toDate:(NSDate*)todate
              creatorID:(NSString*)creatorid
              creatDate:(NSDate*)creatdate
              completed:(BOOL)c
                 passed:(BOOL)p
{
<<<<<<< HEAD
    [self init];
    self.title = title;
=======
    self = [self init];
    self.titile = titile;
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
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







































































