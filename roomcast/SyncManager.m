//
//  SyncManager.m
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "SyncManager.h"

@implementation SyncManager

+(SyncManager *) sharedManager{
    static SyncManager* sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SyncManager alloc] init];
    });
    return sharedManager;
}

-(id) init{
    self = [super init];
    self.delegate = [[ParseSyncManager alloc] init];
    return self;
}

-(void) syncWithConversation:(Conversation*) conversation{
    [self.delegate syncWithConversation:conversation];
}

-(void) syncWithConversations{
    [self.delegate syncWithConversations];
}

-(BOOL) syncWithDevelopment:(NSString*) objectId{
    return [self.delegate syncWithDevelopment:objectId];
}

-(void) syncWithDevelopments: (NSString*)objectId{
    [self.delegate syncWithDevelopments:objectId];
}

-(void) syncWithBlock:(Block *)block{
    [self.delegate syncWithBlock:block];
}

-(void) syncWithNotifications{
    [self.delegate syncWithNotifications];
}

-(void) syncWithButtons{
    [self.delegate syncWithButtons];
}

@end
