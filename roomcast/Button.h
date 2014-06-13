//
//  Button.h
//  roomcast
//
//  Created by Tom Lodge on 18/05/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Button : NSObject
@property(nonatomic,strong) NSString  *objectId;
@property(nonatomic,strong) NSString  *name;
@property(nonatomic,strong) NSString  *usage;
@property(nonatomic,strong) NSMutableArray *questions;
@end
