//
//  Development.h
//  roomcast
//
//  Created by Tom Lodge on 27/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Block;

@interface Development : NSManagedObject

@property (nonatomic, retain) NSString * developmentId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSSet *blocks;
@end

@interface Development (CoreDataGeneratedAccessors)

- (void)addBlocksObject:(Block *)value;
- (void)removeBlocksObject:(Block *)value;
- (void)addBlocks:(NSSet *)values;
- (void)removeBlocks:(NSSet *)values;

@end
