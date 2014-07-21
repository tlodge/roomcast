//
//  Util.h
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Util : NSObject
+(NSDictionary*) convertToDict:(PFObject*) anObject options: (NSDictionary*) options;
@end
