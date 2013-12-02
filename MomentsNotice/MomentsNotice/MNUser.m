//
//  MNUser.m
//  MomentsNotice
//
//  Created by LiuLeon on 11/6/2013.
//  Copyright (c) 2013 LiuLeon. All rights reserved.
//

#import "MNUser.h"
#import <Parse/Parse.h>

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
                   block2:(BOOL) b2
{
    // use this function to add a user to the database, the key is userID. and assign the information to self.userId self.nickname etc.
    // set pairedUserId to @"" when first add a user to database
    // when add operation is failed, like the userID is confilct with some userID in database, need generate some alert window.
    PFObject *user = [PFObject objectWithClassName:@"Userlist"];
    [user setObject:userID forKey:@"UserID"];
    [user setObject:password forKey:@"password"];
    [user setObject:nickname forKey:@"nickname"];
    [user setObject:phoneNumber forKey:@"phoneNumber"];
    [user setObject:address forKey:@"address"];
    NSString *pairedUserID=@"";
    [user setObject:pairedUserID forKey:@"pairedUserID"];
    NSNumber *val = [NSNumber numberWithInt:userType];
    NSLog(@"user Type in mnuser: %d", userType);
    [user setObject:val forKey:@"userType"];
    //[user setObject:b1 forKey:@"block1"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Userlist"];
    [query whereKey:@"UserID" equalTo:userID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            // NSLog(@"The getFirstObject request failed.");
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (!error) {
                    // Show success message
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the user" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        } else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"The Username already exists"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            // The find succeeded.
            // NSLog(@"Successfully retrieved the object.");
        }
    }];
    
}



-(id) initWithUserID:(NSString*) userID   // private function
              password:(NSString*) password
              nikename:(NSString*) nickname
         phoneNunber:(NSString *)phoneNumber
             address:(NSString *)address
            usertype:(int)userType
          pairedUser:(NSString *)pairedUserID
              block1:(BOOL)b1
              block2:(BOOL)b2
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
    /*if([userID isEqualToString:@"leon"] && [password isEqualToString:@"cmpt275"])
     {
     MNUser* tempUser = [[MNUser alloc] initWithUserID:@"leon" password:@"cmpt275" nikename:@"leon" phoneNunber:@"6047210317" address:@"Surrey" usertype:PRIMARY_USER pairedUser:@"" block1:YES block2:YES];
     return tempUser;
     }
     else if([userID isEqualToString:@"chen"] && [password isEqualToString:@"cmpt275"])
     {
     MNUser* tempUser = [[MNUser alloc] initWithUserID:@"chen" password:@"cmpt275" nikename:@"chen" phoneNunber:@"612341234" address:@"Burnaby" usertype:ASSISTANT_USER pairedUser:@"" block1:YES block2:YES];
     return tempUser;
     }*/
    
    //demo
    PFQuery *query = [PFQuery queryWithClassName:@"Userlist"];
    [query whereKey:@"UserID" equalTo:userID];
    [query whereKey:@"password" equalTo:password];
    
    PFObject *object = [query getFirstObject];
    if(!object)
    {
        return nil;
    }
    else{
        // NSString *nickname;
        
        NSString *nickname=[object objectForKey:@"nickname"];
        NSString *phoneNumber=[object objectForKey:@"phoneNumber"];
        NSString *address=[object objectForKey:@"address"];
        NSString *pairedUserID=[object objectForKey:@"pairedUserID"];
        NSNumber *userType = [object objectForKey:@"userType"];
        int type = [userType intValue];
        MNUser* tempUser = [[MNUser alloc] initWithUserID:userID password:password nikename:nickname phoneNunber:phoneNumber address:address usertype:type pairedUser:pairedUserID block1:YES block2:YES];
        return tempUser;
        
    }
    
    
    
    
}


+(MNUser*) fetchUserByUserID:(NSString*)userID;
{
    //user the user ID to fetch the user information from database
    // init and return a MNUser instance
    
    //demo
   // MNUser* tempUser = [[MNUser alloc] initWithUserID:@"chen" password:@"cmpt275" nikename:@"chen" phoneNunber:@"612341234" address:@"Burnaby" usertype:ASSISTANT_USER pairedUser:@"" block1:YES block2:YES];
    //return tempUser;
    //demo
    PFQuery *query = [PFQuery queryWithClassName:@"Userlist"];
    [query whereKey:@"UserID" equalTo:userID];
    
    PFObject *object = [query getFirstObject];
    if(!object)
    {
        return nil;
    }
    else{
        // NSString *nickname;
        NSString *password=[object objectForKey:@"password"];
        NSString *nickname=[object objectForKey:@"nickname"];
        NSString *phoneNumber=[object objectForKey:@"phoneNumber"];
        NSString *address=[object objectForKey:@"address"];
        NSString * pairUserID = [object objectForKey:@"pairedUserID"];
        //int userType = [object objectForKey:@"userType"];
        NSNumber * userType = [object objectForKey:@"userType"];
        int type = [userType intValue];
        
        // *****error hero why hard ASSISTANT_USER and pairedUser.
        MNUser* tempUser = [[MNUser alloc] initWithUserID:userID password:password nikename:nickname phoneNunber:phoneNumber address:address usertype:type pairedUser:pairUserID block1:YES block2:YES];
        return tempUser;
        
    }

    
}

//add a exist user object to database

-(void) pairNewAccountWithUserID:(NSString*) userID
{
    self.pairedUserID = userID;
    [self syncUserData];
}

-(void) syncUserData
{
    PFQuery *query = [PFQuery queryWithClassName:@"Userlist"];
    [query whereKey:@"UserID" equalTo:self.userID];
    PFObject *object = [query getFirstObject];
    [object setObject:self.pairedUserID forKey:@"pairedUserID"];
    [object saveInBackground];
    
    //use userID to find the user in database and sync it;
}

@end
