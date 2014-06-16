//
//  Message.h
//  roomcast
//
//  Created by Tom Lodge on 16/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conversation;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSDate * sent;
@property (nonatomic, retain) Conversation *conversation;

@end
