//
//  ParseRPCManager.m
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "ParseRPCManager.h"

@implementation ParseRPCManager

-(void) createConversationWithMessage:(NSString *)msg parameters:(NSDictionary *)params{
    
    NSLog(@"AM CREATING A NEW CONVERSATION!!! %@ %@", msg, params);
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:msg forKey:@"message"];
    [parameters addEntriesFromDictionary:params];
    
    NSLog(@"params are %@", parameters);
    
    [PFCloud callFunctionInBackground:@"createConversation" withParameters:parameters block:^(PFObject* message, NSError *error){
        NSLog(@"called create conversation!");
        NSLog(@"error is %@", error);
        NSLog(@"message is %@", message);
        
        PFObject *conversation = [message objectForKey:@"conversation"];
        
        
        BOOL stored = [[DataManager sharedManager] saveConversation: [Util convertToDict:conversation options:nil] withMessage:  [Util convertToDict:message options:nil]];
        
        if (stored){
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
            [userInfo setObject:[conversation objectId] forKey:@"objectId"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ConversationUpdate" object:nil userInfo:userInfo];
        }
    }];
}


-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)objectId{
    
    PFObject *pfconversation =[PFObject objectWithoutDataWithClassName:@"Conversation" objectId:objectId];
    
    PFObject *msg = [PFObject objectWithClassName:@"Message"];
    [msg setObject:message forKey:@"message"];
    [msg setObject:[NSNumber numberWithBool:NO] forKey:@"anonymous"];
    [msg setObject:pfconversation forKey:@"conversation"];
    
    [msg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //this is run on the main thread.
        if (succeeded){
            //save directly to core data
            
            /*Conversation *conversation = (Conversation *) [self fetchCoreDataWithObjectId: objectId andType:@"Conversation"];
             
             BOOL success = [self addMessageToCoreData:msg forConversation: conversation];
             if (success){
             NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
             [userInfo setObject:objectId forKey:@"objectId"];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"conversationUpdate" object:nil userInfo:userInfo];
             }*/
        }
    }];
}


-(void) setRatingFor:(NSString*)notificationId withValue:(int)rating{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[NSNumber numberWithInt:rating] forKey:@"rating"];
    [parameters setObject:notificationId forKey:@"notificationId"];
    
    [PFCloud callFunctionInBackground:@"provideFeedback" withParameters:parameters block:^(NSString* message, NSError *error){
        NSLog(@"got response %@",  message);
    }
     ];
}


-(void) buttonPressed:(NSString*) buttonId{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:buttonId forKey:@"buttonId"];
    
    //[parameters addEntriesFromDictionary:params];
    
    [PFCloud callFunctionInBackground:@"buttonPressed" withParameters:parameters block:^(PFObject* message, NSError *error){
        NSLog(@"button pressed - got the following %@", message);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationUpdate" object:nil];
    }
     ];
    
}

@end
