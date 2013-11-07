//
//  Message.h
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *body;
@end
