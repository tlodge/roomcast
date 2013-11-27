//
//  Apartment.h
//  roomcast
//
//  Created by Tom Lodge on 27/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Block;

@interface Apartment : NSManagedObject

@property (nonatomic, retain) NSString * apartmentId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * floor;
@property (nonatomic, retain) Block *block;

@end
