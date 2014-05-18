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
#import "Button.h"

#import "Notification.h"

#import <Parse/Parse.h>

@interface DataManager : NSObject
+(DataManager *) sharedManager;

-(Development *) fetchDevelopmentWithObjectId:(NSString *) objectId;
-(Apartment *) fetchApartmentWithObjectId:(NSString *) objectId;
-(Message *) fetchMessageWithObjectId:(NSString *) objectId;
-(Conversation *) fetchConversationWithObjectId:(NSString *) objectId;
-(NSArray *)  fetchNeighboursForDevelopment:(NSString *) objectId;
-(NSArray *) fetchNotifications;

-(BOOL) syncWithDevelopment:(NSString*) objectId;


-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)conversationId;
-(void) createConversationWithMessage:(NSString *) message parameters:(NSDictionary *) params;

-(NSArray *) neighboursForDevelopment:(NSString*)objectId;
-(NSArray *) conversationsForUser;
-(NSArray *) buttonsForUser;
-(NSArray *) messagesForConversation:(NSString*) conversationId;
-(NSArray *) apartmentsForBlock:(NSString *) objectId;

@property(strong, nonatomic) Development* development;

@end
