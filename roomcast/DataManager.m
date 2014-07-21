//
//  DataManager.m
//  roomcast
//
//  Created by Tom Lodge on 28/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()
-(NSManagedObject *) fetchCoreDataWithObjectId: (NSString *) objectId andType: (NSString*) type;
@end

@implementation DataManager

@synthesize development = _development;

NSManagedObjectContext *context;
SyncManager* syncManager;

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
    id delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    syncManager = [SyncManager sharedManager];
    return self;
}


-(NSArray*) fetchNotifications{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notification"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray* notifications = [context executeFetchRequest:fetchRequest error:&error];
    
    if (!error){
         return [notifications sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastUpdate" ascending:NO]]];
    }
    return [NSArray array];
}

-(Development *) development{
    
    if (_development == nil){
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

-(NSArray *) fetchNeighboursForDevelopment:(NSString *)objectId{
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Development"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSArray* developments = [context executeFetchRequest:fetchRequest error:&error];
    
    if (!error){
        return developments;
    }
    return [NSArray array];
}

//move all of the methods above to this single generic one!

-(NSManagedObject *) fetchCoreDataWithObjectId: (NSString *) objectId andType: (NSString*) type{
    
    if (objectId == nil || type == nil)
        return nil;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:type  inManagedObjectContext:context];
    
    //[fetchRequest setReturnsObjectsAsFaults:NO];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedItem = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedItem count] > 0){
        return [fetchedItem objectAtIndex:0];
    }
    return nil;
}

-(NSArray*) fetchAllButtons{
    return [NSArray array];
}

-(NSArray*) fetchAllConversations{
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Conversation"  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* conversations = [context executeFetchRequest:fetchRequest error:&error];
   
    return [conversations sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastUpdate" ascending:YES]]];
}


#pragma getter public methods

-(BOOL) developmentForId:(NSString*) developmentId{
    return [syncManager syncWithDevelopment:developmentId];
}


-(NSArray*) notificationsForUser{
    
    NSArray* notifications = [self fetchNotifications];
    
    if (notifications){
        //[self syncWithNotifications];
        [syncManager syncWithNotifications];
        if ([notifications count] > 0){
            return notifications;
        }
    }
    return [NSArray array];
}

-(NSArray*) neighboursForDevelopment: (NSString*)objectId{
    
    NSArray* developments = [self fetchNeighboursForDevelopment:objectId];
    
    if (developments){
        //check for updates (asynchronously)
        //[self syncWithDevelopments:objectId];
        [syncManager syncWithDevelopments:objectId];
        
        //and return what we currently have...
        if ([developments count] > 0){
            return [developments sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        }
    }
    //return empty array if nothing found in core data!
    return [NSArray array];
}

-(NSArray*) apartmentsForBlock:(NSString *)objectId{
    
    Block *block = (Block*)[self fetchCoreDataWithObjectId:objectId andType:@"Block"];
    
    if (block){
        //[self syncWithBlock:block];
        [syncManager syncWithBlock:block];
        if (block.apartments){
            return [[block.apartments allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        }
    }
    //return empty array if nothing found in core data!
    return [[NSArray alloc]init];
}

-(NSArray*) buttonsForUser{
    //[self syncWithButtons];
    [syncManager syncWithButtons];
    return [self fetchAllButtons];
}

-(NSArray *) conversationsForUser{
    //[self syncWithConversations];
    [syncManager syncWithConversations];
    return [self fetchAllConversations];
}

-(NSArray *) messagesForConversation:(NSString*) objectId{
    
    //could do some caching here too
    
    //sync over network on a background thread
   
    
    //pull current latest from core data
    Conversation *conversation = (Conversation *) [self fetchCoreDataWithObjectId:objectId andType:@"Conversation"];
    
    if (conversation){
        //[self syncWithConversation:conversation];
        [syncManager syncWithConversation:conversation];
        
        if (conversation.messages){
        
            return [[conversation.messages allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sent" ascending:YES]]];
        }
    }
    
    //return empty array if nothing found in core data!
   
    return [[NSArray alloc]init];
}


#pragma setter public methods

-(BOOL) saveCoreObject:(NSDictionary *)cobject ofType:(NSString*) type{
    
    NSManagedObject *n = [self fetchCoreDataWithObjectId:[cobject objectForKey:@"objectId"] andType:type];
    
    
    if (n == nil){
        
        n = [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:context];
        
        for (NSString* key in [cobject allKeys]){
            NSLog(@"setting %@: %@", key, [cobject objectForKey:key]);
            [n setValue:[cobject objectForKey:key] forKey:key];
        }
        
        NSError *derror;
        [context save:&derror];
        
        if (derror){
            NSLog(@"failed to save with error %@", derror);
            return NO;
        }
        return YES;
    }
    
    return NO;
}

/*
 * Adding a message to the conversation is a little more convoluted given its relationship to a conversation
 * so we can't use the generic method above...
 */

-(BOOL) saveMessage:(NSDictionary*) message forConversation:(Conversation*) conversation {
    
    Message  *cm = (Message *)[self fetchCoreDataWithObjectId:[message objectForKey:@"objectId"] andType:@"Message"];
    
    if (cm == nil){
        
        Message* m = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
        [m setValue:[message objectForKey:@"objectId"] forKey:@"objectId"];
        [m setValue:[message objectForKey:@"createdAt"] forKey:@"sent"];
        [m setValue:[message objectForKey:@"message"] forKey:@"body"];
        [m setValue:conversation forKey:@"conversation"];
        
        if ([conversation.lastUpdate compare:[message objectForKey:@"createdAt"]]==NSOrderedAscending){
            [conversation setValue:[message objectForKey:@"createdAt"] forKey:@"lastUpdate"];
        }
        
        int responses = [conversation.responses intValue];
        //responses += 1;
        [conversation setValue:[NSNumber numberWithInt:responses] forKey:@"responses"];
        
        NSError *error;
        
        if (![context save:&error]){
            NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
            return NO;
        }else{
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
            [userInfo setObject:conversation.objectId forKey:@"objectId"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ConversationUpdate" object:nil userInfo:userInfo];
            return YES;
        }
    }
    return NO;
}

-(BOOL) saveConversation:(NSDictionary*) conversation withMessage:(NSDictionary *) message{
    Conversation *c = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Conversation"
                       inManagedObjectContext:context];

    [c setValue:[conversation objectForKey:@"objectId"] forKey:@"objectId"];
    [c setValue:[message objectForKey:@"message"] forKey:@"teaser"];
    [c setValue:[conversation objectForKey:@"scope"] forKey:@"scope"];
    [c setValue:[NSNumber numberWithInt:1] forKey:@"responses"];
    [c setValue:[conversation objectForKey:@"updatedAt"] forKey:@"lastUpdate"];
    [c setValue:@"1D" forKey:@"initiator"];
    [c setValue:[NSDate date] forKey:@"started"];

    Message *m = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Message"
                  inManagedObjectContext:context];

    [m setValue:[message objectForKey:@"objectId"] forKey:@"objectId"];
    [m setValue:@"1D" forKey:@"from"];
    [m setValue:[message objectForKey:@"message"] forKey:@"body"];
    [m setValue:[NSDate date] forKey:@"sent"];
    [m setValue:c forKey:@"conversation"];

    NSError *error;

    if (![context save:&error]){
        NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
        return NO;
    }
    return YES;
}

-(BOOL) saveApartment: (NSDictionary*) apartment forBlock:(Block*) block{

    Apartment *a = (Apartment *) [self fetchCoreDataWithObjectId:[apartment objectForKey:@"objectId"] andType:@"Apartment"];
   
    
    if (a == nil){
     
        a = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:context];
        [a setValue:[apartment objectForKey:@"objectId"] forKey:@"objectId"];
        [a setValue:[apartment objectForKey:@"floor"] forKey:@"floor"];
        [a setValue:[apartment objectForKey:@"name"] forKey:@"name"];
        [a setValue:block forKey:@"block"];
        NSError *cderror;
        
        if (![context save:&cderror]){
            NSLog(@"whoops! couldn't save %@", [cderror localizedDescription]);
            return NO;
        }
        return YES;
    }
    return NO;
}

-(BOOL) saveDevelopment: (NSDictionary*) development withBlocks:(NSArray *)blocks{

    _development = (Development *)[self fetchCoreDataWithObjectId:[development objectForKey:@"objectId"] andType:@"Development"];
 
    id delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
 
    if (_development == nil){
        _development = [NSEntityDescription insertNewObjectForEntityForName:@"Development" inManagedObjectContext:context];
        [_development setValue:[development objectForKey:@"objectId"] forKey:@"objectId"];
    }
 
    NSError *error;
    
    [_development setValue:[development objectForKey:@"name"] forKey:@"name"];
    [_development setValue:[development objectForKey:@"latitude"] forKey:@"latitude"];
    [_development setValue:[development objectForKey:@"longitude"] forKey:@"longitude"];
    [_development setValue:[development objectForKey:@"residents"] forKey:@"residents"];
    
    NSMutableDictionary *lookup = [NSMutableDictionary dictionary];
 
    for (Block* block in _development.blocks){
        [lookup setObject:block forKey:block.objectId];
    }
 
    for (NSDictionary *block in [development objectForKey:@"blocks"]){
       
        Block *b = [lookup objectForKey:[block objectForKey:@"objectId"]];
 
        if (b == nil){
            b = [NSEntityDescription insertNewObjectForEntityForName:@"Block"
            inManagedObjectContext:context];
        }
 
         NSData* jsonfloors =  [NSJSONSerialization  dataWithJSONObject:[block objectForKey:@"floors"] options:NSJSONWritingPrettyPrinted error:&error];
         
         NSString* floors = [[NSString alloc] initWithData:jsonfloors encoding:NSUTF8StringEncoding];
         
         [b setValue:[block objectForKey:@"objectId"] forKey:@"objectId"];
         [b setValue:[block objectForKey:@"name"] forKey:@"name"];
         [b setValue:floors forKey:@"floors"];
         [b setValue:[block objectForKey:@"residents"] forKey:@"residents"];
         [b setValue:_development forKey:@"development"];
    }
         
    if (![context save:&error]){
        NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
        return NO;
    }
    return YES;
}

@end
