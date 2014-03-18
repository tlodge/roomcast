//
//  RootAudienceViewController.h
//  roomcast
//
//  Created by Tom Lodge on 25/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DestinationViewController.h"

@interface RootAudienceViewController : UITableViewController <MessageScopeDelegate>

@property (strong,nonatomic) NSMutableDictionary *scope;
@property (strong,nonatomic) NSMutableDictionary* totals;
@property (strong,nonatomic) Development* development;
@property (strong,nonatomic) NSArray* developments;
@property (strong,nonatomic) NSString *currentScope;
@property (strong,nonatomic) NSArray* TYPES;
@property (weak, nonatomic) IBOutlet UILabel *whoToSummaryLabel;

@end
