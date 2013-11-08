//
//  MNEvent.h
//  MomentsNotice
//
//  Created by LiuLeon on 11/7/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNEvent : NSObject

@property (strong,nonatomic) NSString* title;
@property (strong,nonatomic) NSString* detail;
@property (strong,nonatomic) NSDate* fromDate;
@property (strong,nonatomic) NSDate* toDate;
//some other date like remeber date can be calculated by fromdate or to date
@property (strong,nonatomic) NSDate* creatDate;
@property (strong,nonatomic) NSString* creatorID;
@property BOOL completed;
@property BOOL passed;

//for the creation of a new event
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
-(void) initWithTitle:(NSString*)title
=======
-(id) initWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
=======
-(id) initWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
=======
-(id) initWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
               detail:(NSString*)detail
             fromDate:(NSDate*)fromdate
               toDate:(NSDate*)todate
            creatorID:(NSString*)creatorid;

//for reloading events from database
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
-(void) reloadWithTitle:(NSString*)title
=======
-(id) initReloadWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
=======
-(id) initReloadWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
=======
-(id) initReloadWithTitle:(NSString*)titile
>>>>>>> 9cf97bc9734ae8e3b289f7289c859c6cc202b363
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
