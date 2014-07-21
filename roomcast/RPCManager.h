//
//  RPCManager.h
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPCProtocol.h"
#import "ParseRPCManager.h"


@interface RPCManager : NSObject <RPCProtocol>

+(RPCManager *) sharedManager;
@property(nonatomic, strong) id <RPCProtocol> delegate;

@end
