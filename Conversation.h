//
//  Conversation.h
//  roomcast
//
//  Created by Tom Lodge on 04/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface Conversation : NSManagedObject

@property (nonatomic, retain) NSString * conversationId;
@property (nonatomic, retain) NSString * initiator;
@property (nonatomic, retain) NSDate * started;
@property (nonatomic, retain) NSString * teaser;
@property (nonatomic, retain) NSSet *messages;
@end

@interface Conversation (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
