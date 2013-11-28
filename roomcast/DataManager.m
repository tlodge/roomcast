//
//  DataManager.m
//  roomcast
//
//  Created by Tom Lodge on 28/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

@synthesize development = _development;
NSManagedObjectContext *context;

+(DataManager *) sharedManager{
    static DataManager* sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[DataManager alloc] init];
    });
    return sharedManager;
}

-(id) init{
    self = [super init];
    NSLog(@"am initing the singleton!");
    id delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    return self;
}

-(BOOL) syncWithDevelopment:(NSString*) developmentId{
    PFQuery *query = [PFQuery queryWithClassName:@"Development"];
    
    [query includeKey:@"blocks"];
    
    NSError *error;
    
    PFObject *pfdev = [query getObjectWithId:developmentId error:&error];
    
    //[query getObjectInBackgroundWithId:developmentId block:^(PFObject *object, NSError *error) {
    //    PFObject *pfdev = object;
        
        if (error){
            NSLog(@"error!! %@ %@", error, [error userInfo]);
            return NO;
        }else{
            
            _development = [self fetchDevelopmentWithObjectId:[pfdev objectId]];
            
            id delegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = [delegate managedObjectContext];
            
            if (_development == nil){
                _development = [NSEntityDescription insertNewObjectForEntityForName:@"Development" inManagedObjectContext:context];
                [_development setValue:[pfdev objectId] forKey:@"developmentId"];
            }
            
            NSError *error;
            
            
            PFGeoPoint* gp = [pfdev objectForKey:@"location"];
            [_development setValue:[pfdev objectForKey:@"name"] forKey:@"name"];
            [_development setValue:[NSNumber numberWithDouble: gp.latitude] forKey:@"latitude"];
            [_development setValue:[NSNumber numberWithDouble: gp.longitude] forKey:@"longitude"];
            
            //NSArray *storedBlocks = [development.blocks valueForKey:@"blockId"];
            NSMutableDictionary *lookup = [NSMutableDictionary dictionary];
            
            for (Block* block in _development.blocks){
                [lookup setObject:block forKey:block.blockId];
            }
            
            for (PFObject *block in [pfdev objectForKey:@"blocks"]){
                Block *b = [lookup objectForKey:[block objectId]];
                
                if (b == nil){
                    b = [NSEntityDescription insertNewObjectForEntityForName:@"Block"
                                                      inManagedObjectContext:context];
                }
                
                NSData* jsonfloors =  [NSJSONSerialization  dataWithJSONObject:[block objectForKey:@"floors"] options:NSJSONWritingPrettyPrinted error:&error];
                
                NSString* floors = [[NSString alloc] initWithData:jsonfloors encoding:NSUTF8StringEncoding];
                
                [b setValue:[block objectId] forKey:@"blockId"];
                [b setValue:[block objectForKey:@"name"] forKey:@"name"];
                [b setValue:floors forKey:@"floors"];
                [b setValue:_development forKey:@"development"];
            }
            
            if (![context save:&error]){
                NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
                return NO;
            }
            return YES;
        }
    //}//];
}

-(Development *) development{
    
    if (_development == nil){
        
        NSLog(@"fetching the development from fresh...");
        NSError* error;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Development"  inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        NSArray* fetchedDevelopment = [context executeFetchRequest:fetchRequest error:&error];
        
        if ([fetchedDevelopment count] > 0){
            _development = [fetchedDevelopment objectAtIndex:0];
            return [fetchedDevelopment objectAtIndex:0];
        }
    }
    return _development;
}

-(Development *) fetchDevelopmentWithObjectId:(NSString *) objectId{
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Development"  inManagedObjectContext:context];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"developmentId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedDevelopment = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedDevelopment count] > 0){
        return [fetchedDevelopment objectAtIndex:0];
    }
    
    return nil;
    
}


@end
