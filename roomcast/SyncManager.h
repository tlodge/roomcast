//
//  SyncManager.h
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyncProtocol.h"
#import "ParseSyncManager.h"

@interface SyncManager : NSObject <SyncProtocol>

+(SyncManager *) sharedManager;
@property(nonatomic, strong) id <SyncProtocol> delegate;

@end
