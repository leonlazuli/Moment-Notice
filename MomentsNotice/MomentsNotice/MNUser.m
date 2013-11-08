//
//  MNUser.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNUser.h"

@implementation MNUser
-(id) initWithUserID:(NSString*) userID
              password:(NSString*) password
              nakename:(NSString*) nickname
              usertype:(NSNumber*) userType
            pairedUser:(NSString*) pairedUserID
                block1:(BOOL) b1
                blicK2:(BOOL) b2
{
    self = [self init];
    self.userID = userID;
    self.nickName = nickname;
    self.userType = userType;
    self.password = password;
    self.pairedUserID = pairedUserID;
    self.block1 = b1;
    self.block2 = b2;
    return self;
}

-(void) syncUserData
{
    //???
}

@end
