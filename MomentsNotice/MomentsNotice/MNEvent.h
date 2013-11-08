//
//  MNEvent.h
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNEvent : NSObject

@property (strong,nonatomic) NSString* titile;
@property (strong,nonatomic) NSString* detail;
@property (strong,nonatomic) NSDate* fromDate;
@property (strong,nonatomic) NSDate* toDate;
//some other date like remeber date can be calculated by fromdate or to date
@property (strong,nonatomic) NSDate* creatDate;
@property (strong,nonatomic) NSString* creatorID;
@property BOOL completed;
@property BOOL passed;

//for the creation of a new event
-(void) initWithTitle:(NSString*)titile
               detail:(NSString*)detail
             fromDate:(NSDate*)fromdate
               toDate:(NSDate*)todate
            creatorID:(NSString*)creatorid;

//for reloading events from database
-(void) reloadWithTitle:(NSString*)titile
                 detail:(NSString*)detail
               fromDate:(NSDate*)fromdate
                 toDate:(NSDate*)todate
              creatorID:(NSString*)creatorid
              creatDate:(NSDate*)creatdate
              completed:(BOOL)completed
                 passed:(BOOL)passed;

-(NSString*) stringOfFromDate;
-(NSString*) stringOfToDate;
-(NSString*) stringOfCreatDate;



@end
