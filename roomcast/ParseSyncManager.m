//
//  ParseNetworkManager.m
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "ParseSyncManager.h"

@interface ParseSyncManager ()

@end

@implementation ParseSyncManager


-(void) syncWithNotifications{
    
    [PFCloud callFunctionInBackground:@"notificationsForUser" withParameters:[NSDictionary dictionary] block:^(NSArray* notifications, NSError *error){
        NSLog(@"syncing with notifications...hold tight");
        BOOL update = FALSE;
        
        if(!error){
            if (notifications){
                for (PFObject *notification in notifications){
                    //translate PFObject to Core data object and save!
                    NSDictionary* transformer = @{@"from":@"name"};
                    NSDictionary* toadd       = @{@"lastUpdate":[notification updatedAt]};
                    NSArray*      ignore      = @[@"readcount", @"context"];
                    
                    NSDictionary *options = @{@"transformer":transformer, @"ignore":ignore, @"add":toadd};
                    
                    update = update || [[DataManager sharedManager] saveCoreObject:[Util convertToDict:notification options:options] ofType:@"Notification"];
                }
                if (update){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationUpdate" object:nil];
                }
            }
        }
    }];
}


-(void) syncWithDevelopments:(NSString*) objectId{
    
    NSLog(@"syncing with developments for %@", objectId);
    
    NSDictionary* parameters= [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:objectId, nil] forKeys:[[NSArray alloc] initWithObjects:@"objectId", nil]];
    
    [PFCloud callFunctionInBackground:@"neighboursForDevelopment" withParameters:parameters block:^(NSArray* developments, NSError *error){
        if(!error){
            if (developments){
                BOOL update = FALSE;
                
                for (PFObject *development in developments){
                    
                    [[DataManager sharedManager] saveCoreObject:[Util convertToDict:development options: nil] ofType:@"Development"];
                    
                    /*Development  *d = (Development *)[self fetchCoreDataWithObjectId:[development objectId] andType:@"Development"];
                    
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
                    }*/
                }
                if (update){
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"developmentsUpdate" object:nil];
                }
            }
        }
    }];
    
}

-(void) syncWithButtons{
    NSLog(@"syncing with buttons!");
    
    //check that we need to explicitly send user details...
    
    PFUser *currentUser = [PFUser currentUser];
    
    NSDictionary* parameters= [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:[currentUser objectId], nil] forKeys:[[NSArray alloc] initWithObjects:@"userId", nil]];
    
    [PFCloud callFunctionInBackground:@"buttonsForUser" withParameters:parameters block:^(NSArray* buttons, NSError *error){
        if(!error){
            if (buttons && [buttons count] > 0){
                NSLog(@"got buttons from parse!");
                NSLog(@"%@", buttons);
                
                NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                
                NSMutableDictionary *groups = [NSMutableDictionary dictionary];
                
                for (PFObject *button in buttons){
                    //[[DataManager sharedManager] saveCoreObject:[Util convertToDict:button options:nil] ofType:@"Button"];
                    
                    NSArray *groupnames =[button objectForKey:@"group"];
                    
                    for (int i = 0; i < [groupnames count]; i++){
                        NSString *groupname = groupnames[i];
                        NSLog(@"group name is %@", groupname);
                        
                        NSMutableArray *bg = [groups objectForKey:groupname];
                        
                        if (bg == nil){
                            bg = [NSMutableArray array];
                        }
                        Button* b   = [[Button alloc] init];
                        b.objectId  = [button objectId];
                        b.name      = [button objectForKey:@"name"];
                        b.questions = [button objectForKey:@"questions"];
                        b.usage     = [button objectForKey:@"usage"];
                        
                        NSLog(@"set button usage to %@", b.usage);
                        
                        [bg addObject:b];
                        [groups setObject:bg forKey:groupname];
                    }
                }
                [userInfo setObject:groups forKey:@"buttongroups"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonUpdate" object:nil userInfo:userInfo];
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
                for (PFObject *conversation in conversations){
                    
                    NSArray     *ignore = @[@"type", @"messages"];
                    NSDictionary *add = @{@"responses":[conversation objectForKey:@"messages"]};
                    NSDictionary *options = @{@"add":add, @"ignore":ignore};
                    
                    [[DataManager sharedManager] saveCoreObject:[Util convertToDict:conversation options:options] ofType:@"Conversation"];
                }
            }
        }
    }];
}

//pull in all new messages associated with a conversation

-(void) syncWithConversation:(Conversation*) conversation{
    
    if (conversation == nil || conversation.objectId == nil)
        return;
    
    PFQuery *innerquery = [PFQuery queryWithClassName:@"Conversation"];
    [innerquery whereKey:@"objectId" equalTo:conversation.objectId];
    
    PFQuery *outerquery = [PFQuery queryWithClassName:@"Message"];
    [outerquery whereKey:@"conversation" matchesKey:@"objectId" inQuery:innerquery];
    
    [outerquery findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        
        if (!error){
        
            if (messages != nil && [messages count] > 0){
                for (PFObject *message in messages){
                
                    [[DataManager sharedManager] saveMessage:[Util convertToDict:message options:nil] forConversation:conversation];
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
    
    if (error){
        NSLog(@"error!! %@ %@", error, [error userInfo]);
        return NO;
    }else{
        PFObject *pfdev = [query getObjectWithId:objectId error:&error];
        NSMutableArray *blocks;
        
        NSArray* ignore = @[@"location"];
        PFGeoPoint* gp = [pfdev objectForKey:@"location"];
        
        NSDictionary *add = @{@"latitude":[NSNumber numberWithDouble: gp.latitude], @"longitude":[NSNumber numberWithDouble: gp.longitude]};
        
        NSDictionary *options = @{@"add":add, @"ignore":ignore};
        NSDictionary* development = [Util convertToDict:pfdev options:options];
        
        for (PFObject* block in [pfdev objectForKey:@"blocks"]){
            [blocks addObject:[Util convertToDict:block options:nil]];
        }
        
        [[DataManager sharedManager] saveDevelopment:development withBlocks:blocks];
       
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
                    update = update || [[DataManager sharedManager] saveApartment:[Util convertToDict:apartment options:nil] forBlock:block];
                }
                if (update){
                    NSDictionary *userInfo = @{@"objectId": block.objectId};
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"BlockUpdate" object:nil userInfo:userInfo];
                }
            }
        }
    }];
}

@end
