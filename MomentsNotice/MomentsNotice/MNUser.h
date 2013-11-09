//
//  MNUser.h
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRIMARY_USER 0
#define ASSISTANT_USER 1


@interface MNUser : NSObject

@property(nonatomic,strong) NSString* userID;
@property(nonatomic,strong) NSString* nickName;
// just a nickName, not the identifier

@property(nonatomic,strong) NSNumber*  userType;
// we will use macro for the userType, PRIMARY_USER and ASSISTANT_USER

@property(nonatomic, strong) NSString* password;
@property(nonatomic, strong) NSString* pairedUserID;
@property BOOL block1;//for the future use.
@property BOOL block2;
// more blocks


-(id) initWithUserID:(NSString*) userID
              password:(NSString*) password
              nakename:(NSString*) nickname
              usertype:(NSNumber*) userType
            pairedUser:(NSString*) pairedUserID
                block1:(BOOL) b1
                blicK2:(BOOL) b2;

//use the userID and userPassword to check whether the pass word is right
//if userID and uerPassWord are valid, then return a MNUser, else return nil;
+(MNUser*) checkUserID:(NSString*) userID
         password:(NSString*) password;

//add a exist user object to database

-(void) syncUserData; // to syncNize the userdata to the database




@end
