//
//  Util.m
//  roomcast
//
//  Created by Tom Lodge on 21/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "Util.h"


@implementation Util
/*
 * The 'transformer' dict is used to pull out attributes from nested PFObjects
 * so for example, if an attribute has a 'from' key with PFObject <ButtonTeam> which
 * has a 'name' attribute, then the transformer could have an entry {from, name}
 */

+(NSDictionary*) convertToDict:(PFObject*) anObject options: (NSDictionary*) options{
    
    NSDictionary* transformer = [options objectForKey:@"transformer"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSArray          *allKeys = [anObject allKeys];
    NSArray *keysToIgnore     = [@[[anObject parseClassName], @"ACL"] arrayByAddingObjectsFromArray:[options objectForKey:@"ignore"]];
    
    for (NSString *key in allKeys){
        if (![keysToIgnore containsObject:key]){
            if (transformer != nil){
                NSString *nestedKey = [transformer objectForKey:key];
                
                if (nestedKey != nil){
                    [dict setObject:[[anObject objectForKey:key] objectForKey:nestedKey] forKey:key];
                }else{
                    [dict setObject:[anObject objectForKey:key] forKey:key];
                }
            }else{
                [dict setObject:[anObject objectForKey:key] forKey:key];
            }
        }
    }
    [dict setObject:[anObject objectId] forKey:@"objectId"];
    [dict addEntriesFromDictionary:[options objectForKey:@"add"]];
    return dict;
}


@end
