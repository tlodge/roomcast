//
//  Notification.h
//  roomcast
//
//  Created by Tom Lodge on 22/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notification : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSNumber * ttl;
@property (nonatomic, retain) NSString * type;

@end
