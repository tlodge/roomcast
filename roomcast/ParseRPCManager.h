//
//  ParseRPCManager.h
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "RPCProtocol.h"
#import "DataManager.h"
#import "Util.h"

@interface ParseRPCManager : NSObject <RPCProtocol>

//call conversation custom cloud code
-(void) createConversationWithMessage:(NSString *)message parameters:(NSDictionary *)params;
-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)conversationId;

//call button custom cloud code
-(void) setRatingFor:(NSString*)notificationId withValue:(int)rating;
-(void) buttonPressed:(NSString*) buttonId;

@end
