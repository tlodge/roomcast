//
//  Message.h
//  roomcast
//
//  Created by Tom Lodge on 12/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conversation;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSDate * sent;
@property (nonatomic, retain) Conversation *conversation;

@end
