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
@property(nonatomic,strong) NSString* phoneNumber;
@property(nonatomic,strong) NSString* address;

@property int  userType;
// we will use macro for the userType, PRIMARY_USER and ASSISTANT_USER

@property(nonatomic, strong) NSString* password;
@property(nonatomic, strong) NSString* pairedUserID;
@property BOOL block1;//for the future use.
@property BOOL block2;
// more blocks

+(void) addUserWithUserID:(NSString*) userID
                passwaord:(NSString*) password
                 nikename:(NSString*) nickname
              phoneNumber:(NSString*) phoneNumber
                  address:(NSString*) address
                 userType:(int) userType
                   block1:(BOOL) b1
                   blicK2:(BOOL) b2;

//-(id) initWithUserID:(NSString*) userID // only for test
//              password:(NSString*) password
//              nikename:(NSString*) nickname
//         phoneNunber:(NSString*) phoneNumber
//             address:(NSString*) address
//              usertype:(NSNumber*) userType
//            pairedUser:(NSString*) pairedUserID
//                block1:(BOOL) b1
//                blicK2:(BOOL) b2;

//use the userID and userPassword to check whether the pass word is right
//if userID and uerPassWord are valid, then return a MNUser, else return nil;
-(void) pairNewAccountWithUserID:(NSString*) userID;

+(MNUser*) checkUserID:(NSString*) userID
         password:(NSString*) password;

//add a exist user object to database

+(MNUser*) fetchUserByUserID:(NSString*)userID;

-(void) syncUserData; // to syncNize the userdata to the database




@end
