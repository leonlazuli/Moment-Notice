//
//  MNUser.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNUser.h"

@interface MNUser()



@end

@implementation MNUser

+(void) addUserWithUserID:(NSString*) userID
                passwaord:(NSString*) password
                 nikename:(NSString*) nickname
              phoneNumber:(NSString*) phoneNumber
                  address:(NSString*) address
                 userType:(int) userType
                   block1:(BOOL) b1
                   blicK2:(BOOL) b2
{
    // use this function to add a user to the database, the key is userID. and assign the information to self.userId self.nickname etc.
    // set pairedUserId to @"" when first add a user to database
    // when add operation is failed, like the userID is confilct with some userID in database, need generate some alert window.
}

-(id) initWithUserID:(NSString*) userID   // private function
              password:(NSString*) password
              nikename:(NSString*) nickname
         phoneNunber:(NSString *)phoneNumber
             address:(NSString *)address
            usertype:(int)userType
          pairedUser:(NSString *)pairedUserID
              block1:(BOOL)b1
              blicK2:(BOOL)b2
{
    self = [self init];
    self.userID = userID;
    self.nickName = nickname;
    self.phoneNumber = phoneNumber;
    self.address = address;
    self.userType = userType;
    self.password = password;
    self.pairedUserID = pairedUserID;
    self.block1 = b1;
    self.block2 = b2;
    return self;
}

+(MNUser*) checkUserID:(NSString*) userID
              password:(NSString*) password
{
    //check from database
    //if valid, then fetch all information, then initial all MNUser object return it
    //else return nil.
    //
    
    //demo
    if([userID isEqualToString:@"leon"] && [password isEqualToString:@"cmpt275"])
    {
        MNUser* tempUser = [[MNUser alloc] initWithUserID:@"leon" password:@"cmpt275" nikename:@"leon" phoneNunber:@"6047210317" address:@"Surrey" usertype:PRIMARY_USER pairedUser:@"" block1:YES blicK2:YES];
        return tempUser;
    }
    else if([userID isEqualToString:@"chen"] && [password isEqualToString:@"cmpt275"])
    {
        MNUser* tempUser = [[MNUser alloc] initWithUserID:@"chen" password:@"cmpt275" nikename:@"chen" phoneNunber:@"612341234" address:@"Burnaby" usertype:ASSISTANT_USER pairedUser:@"" block1:YES blicK2:YES];
        return tempUser;
    }
    else
        return nil;
    //demo
}

+(MNUser*) fetchUserByUserID:(NSString*)userID;
{
    //user the user ID to fetch the user information from database
    // init and return a MNUser instance
    
    //demo
    MNUser* tempUser = [[MNUser alloc] initWithUserID:@"chen" password:@"cmpt275" nikename:@"chen" phoneNunber:@"612341234" address:@"Burnaby" usertype:ASSISTANT_USER pairedUser:@"" block1:YES blicK2:YES];
    return tempUser;
    //demo
    
}

//add a exist user object to database

-(void) pairNewAccountWithUserID:(NSString*) userID
{
    self.pairedUserID = userID;
    [self syncUserData];
}

-(void) syncUserData
{
    //use userID to find the user in database and sync it;
}

@end
