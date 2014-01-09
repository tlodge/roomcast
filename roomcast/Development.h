//
//  Development.h
//  roomcast
//
//  Created by Tom Lodge on 09/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Space.h"

@class Block;

@interface Development : Space

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * residents;
@property (nonatomic, retain) NSSet *blocks;
@end

@interface Development (CoreDataGeneratedAccessors)

- (void)addBlocksObject:(Block *)value;
- (void)removeBlocksObject:(Block *)value;
- (void)addBlocks:(NSSet *)values;
- (void)removeBlocks:(NSSet *)values;

@end
