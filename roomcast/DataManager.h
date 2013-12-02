//
//  DataManager.h
//  roomcast
//
//  Created by Tom Lodge on 28/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Development.h"
#import "Block.h"
#import "Apartment.h"

#import <Parse/Parse.h>

@interface DataManager : NSObject
+(DataManager *) sharedManager;
-(Development *) fetchDevelopmentWithObjectId:(NSString *) objectId;
-(Apartment *) fetchApartmentWithObjectId:(NSString *) objectId;

-(BOOL) syncWithDevelopment:(NSString*) developmentId;
-(BOOL) syncWithBlock:(Block *)block;

@property(weak, nonatomic) Development* development;

@end
