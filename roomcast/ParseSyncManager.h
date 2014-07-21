//
//  ParseNetworkManager.h
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "DataManager.h"
#import "SyncProtocol.h"
#import "Util.h"

@interface ParseSyncManager : NSObject <SyncProtocol>

@end
