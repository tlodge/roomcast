//
//  RPCManager.m
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "RPCManager.h"

@implementation RPCManager

+(RPCManager *) sharedManager{
    static RPCManager* sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[RPCManager alloc] init];
    });
    return sharedManager;
}

-(id) init{
    self = [super init];
    self.delegate = [[ParseRPCManager alloc] init];
    return self;
}


-(void) createConversationWithMessage:(NSString *)message parameters:(NSDictionary *)params{
    [self.delegate createConversationWithMessage:message parameters:params];
}

-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)conversationId{
    [self.delegate addMessageToConversation:message forConversationId:conversationId];
}

-(void) setRatingFor:(NSString*)notificationId withValue:(int)rating{
    [self.delegate setRatingFor:notificationId withValue:rating];
}

-(void) buttonPressed:(NSString*) buttonId{
    [self.delegate buttonPressed:buttonId];
}

-(void) loadAuthZonesForDevelopment:(NSString *) developmentId  withCallback: (void(^)(NSArray* zones)) callback{
    [self.delegate loadAuthZonesForDevelopment:developmentId withCallback:callback];
}


-(void) registerUser: (NSDictionary *) duser withApartmentName:(NSString*) apartmentName withFloor:(NSString*) floor withDevelopment:(Development*) development  withBlock:(Block*)blk withCallback: (void(^)(BOOL succeeded, NSError *error)) callback{
    [self.delegate registerUser:duser withApartmentName: apartmentName withFloor:floor withDevelopment: development  withBlock:(Block*)blk  withCallback:callback];
}


@end
