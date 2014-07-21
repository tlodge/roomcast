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
#import "SyncManager.h"

@interface DataManager : NSObject
+(DataManager *) sharedManager;

//should any of the following be public??

-(BOOL) developmentForId:(NSString*) developmentId;
-(NSArray *) neighboursForDevelopment:(NSString*)objectId;
-(NSArray *) conversationsForUser;
-(NSArray *) buttonsForUser;
-(NSArray *) messagesForConversation:(NSString*) conversationId;
-(NSArray *) apartmentsForBlock:(NSString *) objectId;
-(NSArray *) notificationsForUser;

-(BOOL) saveCoreObject:(NSDictionary *)cobject ofType:(NSString*) type;
-(BOOL) saveMessage:(NSDictionary*) message forConversation:(Conversation*) conversation;
-(BOOL) saveApartment: (NSDictionary*) apartment forBlock:(Block*) block;
-(BOOL) saveDevelopment:(NSDictionary*) development withBlocks:(NSArray*)blocks;
-(BOOL) saveConversation:(NSDictionary*) conversation withMessage:(NSDictionary *) message;
    
@property(strong, nonatomic) Development* development;

@end
