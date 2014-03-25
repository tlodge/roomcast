//
//  RootAudienceViewController.h
//  roomcast
//
//  Created by Tom Lodge on 25/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationViewController.h"
#import "FilterViewController.h"

@interface RootAudienceViewController : UITableViewController <MessageScopeDelegate, MessageFilterDelegate, UITextViewDelegate>

/*
 * Following three passed in from sendrootviewcontroller;
 */
@property (weak,nonatomic) NSMutableDictionary *scope;
@property (weak, nonatomic) NSArray *scopeTypes;

@property (weak,nonatomic) NSString *currentScope;
@property (weak,nonatomic) NSArray* filters;
@property (weak,nonatomic) NSArray* filterDescriptions;
@property (weak,nonatomic) NSMutableArray* selectedFilters;

@property (weak,nonatomic) NSMutableDictionary* totals;
@property (weak,nonatomic) Development* development;
@property (weak,nonatomic) NSArray* developments;

@property (assign, nonatomic) id <MessageScopeDelegate> scopedelegate;
@property (assign, nonatomic) id <MessageFilterDelegate> filterdelegate;
@property (weak, nonatomic) IBOutlet UILabel *whoToSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *filterSummaryLabel;

@end
