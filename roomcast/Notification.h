//
//  Notification.h
//  roomcast
//
//  Created by Tom Lodge on 26/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notification : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSDate * lastUpdate;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * objectId;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSDate   * read;
@property (nonatomic, retain) NSNumber * ttl;
@property (nonatomic, retain) NSString * type;

@end
