//
//  DataManager.h
//  roomcast
//
//  Created by Tom Lodge on 28/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Development.h"
#import "Block.h"
#import "Apartment.h"
#import "Conversation.h"
#import "Message.h"
#import <Parse/Parse.h>

@interface DataManager : NSObject
+(DataManager *) sharedManager;

-(Development *) fetchDevelopmentWithObjectId:(NSString *) objectId;
-(Apartment *) fetchApartmentWithObjectId:(NSString *) objectId;
-(Message *) fetchMessageWithObjectId:(NSString *) objectId;
-(Conversation *) fetchConversationWithObjectId:(NSString *) objectId;

-(BOOL) syncWithDevelopment:(NSString*) developmentId;



-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)conversationId;
-(void) createConversationWithMessage:(NSString *) message parameters:(NSDictionary *) params;

-(NSArray *) conversationsForUser;
-(NSArray *) messagesForConversation:(NSString*) conversationId;
-(NSArray *) apartmentsForBlock:(NSString *) blockId;

@property(weak, nonatomic) Development* development;

@end
