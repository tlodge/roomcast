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

@protocol MessageScopeDelegate;

@interface DestinationViewController : UITableViewController <ApartmentAddDelegate, DevelopmentAddDelegate, DevelopmentsAddDelegate>


@property(strong, nonatomic) NSMutableDictionary *scope;
@property(strong, nonatomic) NSMutableDictionary *filter;
@property(strong, nonatomic) NSString *currentScope;
@property(weak, nonatomic)  NSArray *scopeTypes;
@property(weak, nonatomic) NSMutableDictionary *totals;
@property(strong, nonatomic) NSIndexPath *lastIndex;
@property(strong, nonatomic) NSArray *blocks;
@property(strong, nonatomic) NSArray *developments;
@property(strong, nonatomic)  NSString *developmentName;

@property(assign, nonatomic) id <MessageScopeDelegate> scopedelegate;
@end

@protocol MessageScopeDelegate <NSObject>
-(void) didSelectScope:(NSString*) scopeName withValues:(NSDictionary*) scopeValues;
@end