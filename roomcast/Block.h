//
//  Block.h
//  roomcast
//
//  Created by Tom Lodge on 09/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Space.h"

@class Apartment, Development;

@interface Block : Space

@property (nonatomic, retain) NSString * floors;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * residents;
@property (nonatomic, retain) NSSet *apartments;
@property (nonatomic, retain) Development *development;
@end

@interface Block (CoreDataGeneratedAccessors)

- (void)addApartmentsObject:(Apartment *)value;
- (void)removeApartmentsObject:(Apartment *)value;
- (void)addApartments:(NSSet *)values;
- (void)removeApartments:(NSSet *)values;

@end
