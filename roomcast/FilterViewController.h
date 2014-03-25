//
//  FilterViewController.h
//  roomcast
//
//  Created by Tom Lodge on 22/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterCell.h"
#import "MessageFilterProtocol.h"

@interface FilterViewController : UITableViewController
@property(nonatomic, weak) NSArray *filters;
@property(nonatomic, weak) NSArray *filterDescriptions;

@property(nonatomic, weak) NSMutableArray *selectedFilters;
@property(nonatomic, assign) id <MessageFilterDelegate> filterdelegate;
@end
