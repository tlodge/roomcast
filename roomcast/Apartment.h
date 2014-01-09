//
//  Apartment.h
//  roomcast
//
//  Created by Tom Lodge on 09/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Space.h"

@class Block;

@interface Apartment : Space

@property (nonatomic, retain) NSString * floor;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Block *block;

@end
