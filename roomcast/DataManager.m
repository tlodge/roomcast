//
//  DataManager.m
//  roomcast
//
//  Created by Tom Lodge on 28/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DataManager.h"

@interface DataManager ()
-(void) syncWithConversation:(Conversation*) conversation;
-(void) syncWithConversations;
-(void) syncWithDevelopments: (NSString*)objectId;
-(void) syncWithBlock:(Block *)block;
-(void) createSomeNotifications;

//-(BOOL) addMessageToCoreData:(PFObject*) message;
//-(BOOL) addMessageToCoreData:(PFObject*) message forConversation:(Conversation*) conversation;
//-(BOOL) addConversationToCoreData:(PFObject*) conversation withMessage:(PFObject*)message;
-(BOOL) addConversationToCoreData:(PFObject*) message;

@end

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
    id delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];
    [self createSomeNotifications];
    //add some notifications if don't exist
    return self;
}

-(void) createSomeNotifications{
    
    
    NSArray* notifications = [self fetchNotifications];
    
    if ([notifications count] > 0){
        return;
    }
    
    NSArray *messages = @[@"We've had reports of muggings along the riverside path.  Please be on your guard.  If you would like us to escort you, press the 'escort me' button.", @"Please ensure that you move everything off your balcony tonight as the forecast is for high southerly winds.", @"The lifts in Block B are due a maintenance check on Saturday, so will be out of order for a couple of hours at lunch."];
    
    NSArray *froms = @[@"security", @"concierge", @"maintenance"];
   
    for (int i = 0; i < [messages count]; i++){
    
        Notification *n = [NSEntityDescription insertNewObjectForEntityForName:@"Notification" inManagedObjectContext:context];
        
        [n setValue:froms[i] forKey:@"from"];
        [n setValue:messages[i] forKey:@"message"];
        [n setValue:[NSNumber numberWithInt:360] forKey:@"ttl"];
        [n setValue:[NSNumber numberWithInt:1] forKey:@"priorty"];
        [n setValue:@"anobjectId" forKey:@"objectId"];
        NSError *error;
        
        [context save:&error];
        
        if (error){
            NSLog(@"failed to save with error %@", error);
        }
    }
}

-(NSArray*) fetchNotifications{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notification"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    
    NSArray* notifications = [context executeFetchRequest:fetchRequest error:&error];
    
    if (!error){
        return notifications;
    }
    return [[NSArray alloc] init];
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

-(Apartment *) fetchApartmentWithObjectId:(NSString *) objectId{
    
    if (objectId == nil)
        return nil;

    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Apartment"  inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", objectId];
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedDevelopment = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedDevelopment count] > 0){
        return [fetchedDevelopment objectAtIndex:0];
    }
    NSLog(@"returning nil for fetch dev with object id %@", objectId);
    return nil;
}


-(Block *) fetchBlockWithObjectId:(NSString *) objectId{
    
    if (objectId == nil)
        return nil;
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Block"  inManagedObjectContext:context];
    
    //[fetchRequest setReturnsObjectsAsFaults:NO];
    
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", objectId];
    [fetchRequest setPredicate:predicate];
    
    NSArray* fetchedBlock = [context executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedBlock count] > 0){
        return [fetchedBlock objectAtIndex:0];
    }
    
    return nil;
    
}


-(NSArray*) fetchAllConversations{
    NSError* error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Conversation"  inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray* conversations = [context executeFetchRequest:fetchRequest error:&error];
   
    return [conversations sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastUpdate" ascending:YES]]];
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
-(void) syncWithDevelopments:(NSString*) objectId{
    
    NSLog(@"syncing with developments for %@", objectId);
    
    NSDictionary* parameters= [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:objectId, nil] forKeys:[[NSArray alloc] initWithObjects:@"objectId", nil]];
    
    [PFCloud callFunctionInBackground:@"neighboursForDevelopment" withParameters:parameters block:^(NSArray* developments, NSError *error){
        if(!error){
            if (developments){
                BOOL update = FALSE;
                NSLog(@"got following from parse");
                NSLog(@"%@",developments);
                for (PFObject *development in developments){
                    
                    Development  *d = [self fetchDevelopmentWithObjectId:[development objectId]];
                    
                    if (d == nil){
                        
                        
                        d = [NSEntityDescription insertNewObjectForEntityForName:@"Development" inManagedObjectContext:context];
                        
                        [d setValue:[development objectId] forKey:@"objectId"];
                        PFGeoPoint* gp = [development objectForKey:@"location"];
                        [d setValue:[development objectForKey:@"name"] forKey:@"name"];
                        [d setValue:[NSNumber numberWithDouble: gp.latitude] forKey:@"latitude"];
                        [d setValue:[NSNumber numberWithDouble: gp.longitude] forKey:@"longitude"];
                        [d setValue:[development objectForKey:@"residents"] forKey:@"residents"];
                       
                        NSError *derror;
                        update = update || [context save:&derror];
                        if (derror){
                            NSLog(@"failed to save with error %@", derror);
                        }
                    }
                }
                if (update){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"developmentsUpdate" object:nil];
                }
            }
        }
    }];

}

-(void) syncWithConversations{
    
    PFUser *currentUser = [PFUser currentUser];
    
    NSDictionary* parameters= [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:[currentUser objectId], nil] forKeys:[[NSArray alloc] initWithObjects:@"userId", nil]];
    
    [PFCloud callFunctionInBackground:@"conversationsForUser" withParameters:parameters block:^(NSArray* conversations, NSError *error){
        if(!error){
            if (conversations){
                
                BOOL update = FALSE;
                
                for (PFObject *conversation in conversations){
                    Conversation  *c = [self fetchConversationWithObjectId:[conversation objectId]];
                    
                    if (c == nil){
                        update = TRUE;
                        c = [NSEntityDescription insertNewObjectForEntityForName:@"Conversation" inManagedObjectContext:context];
                        
                        [c setValue:[conversation objectId] forKey:@"conversationId"];
                        [c setValue:[conversation createdAt] forKey:@"started"];
                        [c setValue:[conversation objectForKey:@"teaser"] forKey:@"teaser"];
                         [c setValue:[conversation objectForKey:@"scope"] forKey:@"scope"];
                        
                    }
                    [c setValue:[conversation objectForKey:@"messages"] forKey:@"responses"];
                    [c setValue:[conversation updatedAt] forKey:@"lastUpdate"];
                   
                    NSError *cderror;
                        
                    update = update || (update && [context save:&cderror]);
                    
                }
                if (update){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"conversationsUpdate" object:nil];
                }
            }
        }
    }];
}

//pull in all new messages associated with a conversation

-(void) syncWithConversation:(Conversation*) conversation{
    
    if (conversation == nil || conversation.conversationId == nil)
        return;
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Conversation"];
    [innerquery whereKey:@"objectId" equalTo:conversation.conversationId];
    
    PFQuery *outerquery = [PFQuery queryWithClassName:@"Message"];
    [outerquery whereKey:@"conversation" matchesKey:@"objectId" inQuery:innerquery];
    
    [outerquery findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        
        if (!error){
            
            BOOL update = FALSE;
            
            if (messages != nil && [messages count] > 0){
                
                for (PFObject *message in messages){
                    
                    Message  *m = [self fetchMessageWithObjectId:[message objectId]];
                    
                    if (m == nil){
                        BOOL success = [self addMessageToCoreData:message forConversation: conversation];
                        update = update || success;
                    }
                }
                if (update){
                    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                    [userInfo setObject:conversation.conversationId forKey:@"conversationId"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"conversationUpdate" object:nil userInfo:userInfo];
                }
            }
        }
    }];
}

-(BOOL) syncWithDevelopment:(NSString*) objectId{
    
    if (!objectId)
        return NO;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Development"];
    
    [query includeKey:@"blocks"];
    
    NSError *error;
    
    PFObject *pfdev = [query getObjectWithId:objectId error:&error];
    
    if (error){
        NSLog(@"error!! %@ %@", error, [error userInfo]);
        return NO;
    }else{
        
        _development = [self fetchDevelopmentWithObjectId:[pfdev objectId]];
        
        id delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        
        if (_development == nil){
            _development = [NSEntityDescription insertNewObjectForEntityForName:@"Development" inManagedObjectContext:context];
            [_development setValue:[pfdev objectId] forKey:@"objectId"];
        }
        
        NSError *error;
        
        
        PFGeoPoint* gp = [pfdev objectForKey:@"location"];
        [_development setValue:[pfdev objectForKey:@"name"] forKey:@"name"];
        [_development setValue:[NSNumber numberWithDouble: gp.latitude] forKey:@"latitude"];
        [_development setValue:[NSNumber numberWithDouble: gp.longitude] forKey:@"longitude"];
        [_development setValue:[pfdev objectForKey:@"residents"] forKey:@"residents"];
        NSMutableDictionary *lookup = [NSMutableDictionary dictionary];
        
        for (Block* block in _development.blocks){
            [lookup setObject:block forKey:block.objectId];
        }
        
        for (PFObject *block in [pfdev objectForKey:@"blocks"]){
            Block *b = [lookup objectForKey:[block objectId]];
            
            if (b == nil){
                b = [NSEntityDescription insertNewObjectForEntityForName:@"Block"
                                                  inManagedObjectContext:context];
            }
            
            NSData* jsonfloors =  [NSJSONSerialization  dataWithJSONObject:[block objectForKey:@"floors"] options:NSJSONWritingPrettyPrinted error:&error];
            
            NSString* floors = [[NSString alloc] initWithData:jsonfloors encoding:NSUTF8StringEncoding];
            
            [b setValue:[block objectId] forKey:@"objectId"];
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
}

-(void) syncWithBlock:(Block*) block{
    
    if (block==nil || block.objectId == nil)
        return;
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Block"];
    [innerquery whereKey:@"objectId" equalTo:block.objectId];
    
    PFQuery *outerquery = [PFQuery queryWithClassName:@"Apartment"];
    [outerquery whereKey:@"block" matchesKey:@"objectId" inQuery:innerquery];
    
    [outerquery findObjectsInBackgroundWithBlock:^(NSArray *apartments, NSError *error) {
        
        if (!error){
            
            BOOL update = FALSE;

            if (apartments != nil && [apartments count] > 0){
        
                for (PFObject *apartment in apartments){
        
                    Apartment *a = [self fetchApartmentWithObjectId:[apartment objectId]];
   
                    if (a == nil){
                        
                        a = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:context];
                        [a setValue:[apartment objectId] forKey:@"objectId"];
                        [a setValue:[apartment objectForKey:@"floor"] forKey:@"floor"];
                        [a setValue:[apartment objectForKey:@"name"] forKey:@"name"];
                        [a setValue:block forKey:@"block"];
                        NSError *cderror;
                        
                        update = update || [context save:&cderror];
                    }
                    if (update){
                        NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                        [userInfo setObject:block.objectId forKey:@"objectId"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"blockUpdate" object:nil userInfo:userInfo];
                    }
                }
            }
        }
    }];
}


-(BOOL) addConversationToCoreData:(PFObject*) message{
    
    PFObject* conversation = [message objectForKey:@"conversation"];
    
    Conversation *c = [NSEntityDescription
                       insertNewObjectForEntityForName:@"Conversation"
                       inManagedObjectContext:context];
    
    [c setValue:[conversation objectId] forKey:@"conversationId"];
    [c setValue:[message objectForKey:@"message"] forKey:@"teaser"];
    [c setValue:[conversation objectForKey:@"scope"] forKey:@"scope"];
    [c setValue:[NSNumber numberWithInt:1] forKey:@"responses"];
    [c setValue:[conversation updatedAt] forKey:@"lastUpdate"];
    [c setValue:@"1D" forKey:@"initiator"];
    [c setValue:[NSDate date] forKey:@"started"];
    
    Message *m = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Message"
                  inManagedObjectContext:context];
    
    [m setValue:[message objectId] forKey:@"messageId"];
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

-(BOOL) addMessageToCoreData:(PFObject*) message forConversation:(Conversation*) conversation {
    
    Message* m = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
    [m setValue:[message objectId] forKey:@"messageId"];
    [m setValue:[message createdAt] forKey:@"sent"];
    [m setValue:[message objectForKey:@"message"] forKey:@"body"];
    [m setValue:conversation forKey:@"conversation"];
    
    if ([conversation.lastUpdate compare:[message createdAt]]==NSOrderedAscending){
        [conversation setValue:[message createdAt] forKey:@"lastUpdate"];
    }
    
    int responses = [conversation.responses intValue];
    //responses += 1;
    [conversation setValue:[NSNumber numberWithInt:responses] forKey:@"responses"];
    
    NSError *error;
    
    if (![context save:&error]){
        NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
        return NO;
    }
    
    
    
    return YES;
}

#pragma setter public methods


-(void) createConversationWithMessage:(NSString *)message parameters:(NSDictionary *)params{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:message forKey:@"message"];
    [parameters addEntriesFromDictionary:params];
    
    NSLog(@"params are %@", parameters);
    
    [PFCloud callFunctionInBackground:@"createConversation" withParameters:parameters block:^(PFObject* message, NSError *error){
        
            PFObject *conversation = [message objectForKey:@"conversation"];
        
            BOOL stored = [self addConversationToCoreData:message];
        
            if (stored){
                    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                    [userInfo setObject:[conversation objectId] forKey:@"conversationId"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"conversationUpdate" object:nil userInfo:userInfo];
            }
        }
    ];

}
/*
-(void) createConversationWithMessage:(NSString *) message parameters:(NSDictionary *) params{
    
     PFObject *co = [PFObject objectWithClassName:@"Conversation"];
     [co setObject:@"normal" forKey:@"type"];
     [co setObject:message forKey:@"teaser"];
     
     PFObject *msg = [PFObject objectWithClassName:@"Message"];
     [msg setObject:message forKey:@"message"];
     [msg setObject:[NSNumber numberWithBool:NO] forKey:@"anonymous"];
     [msg setObject:co forKey:@"conversation"];
     
     [msg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
         if (succeeded){
             BOOL stored = [self addConversationToCoreData:co withMessage: msg];
             if (stored){
                 NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                 [userInfo setObject:[co objectId] forKey:@"conversationId"];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"conversationUpdate" object:nil userInfo:userInfo];
             }
         }
     }];
}
*/

-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)conversationId{
    
    PFObject *pfconversation =[PFObject objectWithoutDataWithClassName:@"Conversation" objectId:conversationId];
    
    PFObject *msg = [PFObject objectWithClassName:@"Message"];
    [msg setObject:message forKey:@"message"];
    [msg setObject:[NSNumber numberWithBool:NO] forKey:@"anonymous"];
    [msg setObject:pfconversation forKey:@"conversation"];
    
    [msg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //this is run on the main thread.
        if (succeeded){
            //save directly to core data
            Conversation *conversation = [self fetchConversationWithObjectId:conversationId];
            BOOL success = [self addMessageToCoreData:msg forConversation: conversation];
            if (success){
                NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                [userInfo setObject:conversationId forKey:@"conversationId"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"conversationUpdate" object:nil userInfo:userInfo];
            }
        }
    }];
}

#pragma getter public methods

-(NSArray*) neighboursForDevelopment: (NSString*)objectId{
    
    NSArray* developments = [self fetchNeighboursForDevelopment:objectId];
    
    if (developments){
        //check for updates (asynchronously)
        [self syncWithDevelopments:objectId];
        
        
        //and return what we currently have...
        if ([developments count] > 0){
            return [developments sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        }
    }
    //return empty array if nothing found in core data!
    return [[NSArray alloc]init];
}

-(NSArray*) apartmentsForBlock:(NSString *)objectId{
    
    Block *block = [self fetchBlockWithObjectId:objectId];
    
    if (block){
        [self syncWithBlock:block];
        
        if (block.apartments){
            return [[block.apartments allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        }
    }
    //return empty array if nothing found in core data!
    return [[NSArray alloc]init];
}

-(NSArray *) conversationsForUser{
    [self syncWithConversations];
    return [self fetchAllConversations];
}

-(NSArray *) messagesForConversation:(NSString*) conversationId{
    
    //could do some caching here too
    
    //sync over network on a background thread
   
    
    //pull current latest from core data
    Conversation *conversation = [self fetchConversationWithObjectId:conversationId];
    
   
    
    if (conversation){
        [self syncWithConversation:conversation];
       
        if (conversation.messages){
        
            return [[conversation.messages allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sent" ascending:YES]]];
        }
    }
    
    //return empty array if nothing found in core data!
   
    return [[NSArray alloc]init];
}

@end
