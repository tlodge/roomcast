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
#import "ApartmentViewController.h"
#import "DevelopmentViewController.h"

@protocol MessageScopeDelegate;

@interface DestinationViewController : UITableViewController <ApartmentAddDelegate, DevelopmentAddDelegate>

@property(retain,nonatomic) NSIndexPath *lastIndex;
@property(retain, nonatomic) NSMutableDictionary *scope;
@property(retain, nonatomic) NSMutableDictionary *filter;
@property(retain, nonatomic) NSString *currentScope;
@property(weak, nonatomic)  NSArray *scopeTypes;
@property(weak, nonatomic) NSMutableDictionary *totals;
//@property(strong, nonatomic) NSMutableDictionary *apartmenttotals;
@property(strong, nonatomic) NSArray *blocks;
@property(strong, nonatomic)  NSString *developmentName;
@property(assign, nonatomic) id <MessageScopeDelegate> scopedelegate;
@end

@protocol MessageScopeDelegate <NSObject>
-(void) didSelectScope:(NSString*) scopeName withValues:(NSDictionary*) scopeValues;
@end