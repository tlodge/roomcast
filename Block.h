//
//  Block.h
//  roomcast
//
//  Created by Tom Lodge on 27/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Apartment, Development;

@interface Block : NSManagedObject

@property (nonatomic, retain) NSString * blockId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * floors;
@property (nonatomic, retain) NSSet *apartments;
@property (nonatomic, retain) Development *development;
@end

@interface Block (CoreDataGeneratedAccessors)

- (void)addApartmentsObject:(Apartment *)value;
- (void)removeApartmentsObject:(Apartment *)value;
- (void)addApartments:(NSSet *)values;
- (void)removeApartments:(NSSet *)values;

@end
