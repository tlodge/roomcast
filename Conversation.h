//
//  Conversation.h
//  roomcast
//
//  Created by Tom Lodge on 14/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface Conversation : NSManagedObject

@property (nonatomic, retain) NSString * conversationId;
@property (nonatomic, retain) NSString * initiator;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSNumber * responses;
@property (nonatomic, retain) NSDate * started;
@property (nonatomic, retain) NSString * teaser;
@property (nonatomic, retain) NSString * scope;
@property (nonatomic, retain) NSSet *messages;
@end

@interface Conversation (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
