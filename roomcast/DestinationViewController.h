//
//  DestinationViewController.h
//  roomcast
//
//  Created by Tom Lodge on 21/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScopeCell.h"
#import "BlockViewController.h"
#import "DevelopmentViewController.h"
#import "DevelopmentsViewController.h"
#import "MessageScopeProtocol.h"

@interface DestinationViewController : UITableViewController <ApartmentAddDelegate, DevelopmentAddDelegate, DevelopmentsAddDelegate>


@property(weak, nonatomic)   NSMutableDictionary *scope;
@property(weak, nonatomic) NSString *currentScope;
@property(weak, nonatomic)  NSArray *scopeTypes;
@property(weak, nonatomic) NSMutableDictionary *totals;

@property(strong, nonatomic) NSIndexPath *segueIndex;

@property(strong, nonatomic) NSArray *blocks;
@property(weak, nonatomic) NSArray *developments;
@property(weak, nonatomic)  NSString *developmentName;

@property(assign, nonatomic) id <MessageScopeDelegate> scopedelegate;
@end
