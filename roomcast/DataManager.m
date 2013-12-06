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



-(Apartment *) fetchApartmentWithObjectId:(NSString *) objectId{
    
    if (objectId == nil)
        return nil;

    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Apartment"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"apartmentId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedApartment = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedApartment count] > 0){
        return [fetchedApartment objectAtIndex:0];
    }
    
    return nil;
    
}


-(Message *) fetchMessageWithObjectId:(NSString *) objectId{
    
    if (objectId == nil)
        return nil;

    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Message"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"messageId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedMessage = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedMessage count] > 0){
        return [fetchedMessage objectAtIndex:0];
    }
    
    return nil;
    
}


-(Development *) fetchDevelopmentWithObjectId:(NSString *) objectId{
    
    if (objectId == nil)
        return nil;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Development"  inManagedObjectContext:context];
    
    //[fetchRequest setReturnsObjectsAsFaults:NO];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"developmentId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedDevelopment = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedDevelopment count] > 0){
        return [fetchedDevelopment objectAtIndex:0];
    }
    
    return nil;
    
}

-(Conversation *) fetchConversationWithObjectId:(NSString *) objectId{
    
    if (objectId == nil)
        return nil;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Conversation"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"conversationId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedConversation = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedConversation count] > 0){
        return [fetchedConversation objectAtIndex:0];
    }
    
    return nil;
}


#pragma sync methods


-(BOOL) syncWithConversations:(NSString*) userId{
    
    BOOL fresh = NO;
    
    NSDictionary* parameters= [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:userId, nil] forKeys:[[NSArray alloc] initWithObjects:@"userId", nil]];
    
    NSArray* conversations = [PFCloud callFunction:@"conversationsForUser" withParameters:parameters];
    
     for (PFObject *conversation in conversations){
         Conversation  *c = [self fetchConversationWithObjectId:[conversation objectId]];
         
         if (c == nil){
           
            c = [NSEntityDescription insertNewObjectForEntityForName:@"Conversation" inManagedObjectContext:context];
             
            [c setValue:[conversation objectId] forKey:@"conversationId"];
            
            [c setValue:[conversation objectForKey:@"teaser"] forKey:@"teaser"];
             
            NSError *cderror;
             
            if (![context save:&cderror]){
                 NSLog(@"whoops! couldn't save %@", [cderror localizedDescription]);
                 return fresh;
            }
            fresh = YES;
         }
     }
    
     return fresh;
}

//pull in all new messages associated with a conversation

-(BOOL) syncWithConversation:(Conversation*) conversation{
    
    if (conversation == nil || conversation.conversationId == nil)
        return NO;
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Conversation"];
    [innerquery whereKey:@"objectId" equalTo:conversation.conversationId];
    
    PFQuery *outerquery = [PFQuery queryWithClassName:@"Message"];
    [outerquery whereKey:@"conversation" matchesKey:@"objectId" inQuery:innerquery];
    
    NSError* error;
    
    NSArray *messages = [outerquery findObjects:&error];
    if (error){
        NSLog(@"ok seen error %@", error);
        return NO;
    }
    
    if (messages != nil && [messages count] > 0){
        
        for (PFObject *message in messages){
            
            Message  *m = [self fetchMessageWithObjectId:[message objectId]];
            
            if (m == nil){
                m = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
                [m setValue:[message objectId] forKey:@"messageId"];
            }
        
            [m setValue:[message objectForKey:@"message"] forKey:@"body"];
            [m setValue:conversation forKey:@"conversation"];
            
            NSError *cderror;
            
            if (![context save:&cderror]){
                NSLog(@"whoops! couldn't save %@", [cderror localizedDescription]);
                return NO;
            }
        }
        return YES;
    }
    return NO;

    
}

-(BOOL) syncWithDevelopment:(NSString*) developmentId{
    
    if (!developmentId)
        return NO;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Development"];
    
    [query includeKey:@"blocks"];
    
    NSError *error;
    
    PFObject *pfdev = [query getObjectWithId:developmentId error:&error];
    
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
}


-(BOOL) syncWithBlock:(Block*) block{
    
    if (block == nil || block.blockId == nil)
        return NO;
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Block"];
    [innerquery whereKey:@"objectId" equalTo:block.blockId];
    
    PFQuery *outerquery = [PFQuery queryWithClassName:@"Apartment"];
    [outerquery whereKey:@"block" matchesKey:@"objectId" inQuery:innerquery];
    
    NSError* error;
    
    NSArray *apartments = [outerquery findObjects:&error];
    
    if (error){
        NSLog(@"ok seen error %@", error);
        return NO;
    }
    
    if (apartments != nil && [apartments count] > 0){
        
        for (PFObject *apartment in apartments){
        
            Apartment *a = [self fetchApartmentWithObjectId:[apartment objectId]];
   
            if (a == nil){
                a = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:context];
                [a setValue:[apartment objectId] forKey:@"apartmentId"];
            }
            
            [a setValue:[apartment objectForKey:@"floor"] forKey:@"floor"];
            [a setValue:[apartment objectForKey:@"name"] forKey:@"name"];
            [a setValue:block forKey:@"block"];
    
            NSError *cderror;
    
            if (![context save:&cderror]){
                NSLog(@"whoops! couldn't save %@", [cderror localizedDescription]);
                return NO;
            }
        }
        return YES;
    }
    return NO;
}


@end
