//
//  DynamicOptionsTableViewController.h
//  roomcast
//
//  Created by Tom Lodge on 22/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionSelectedProtocol.h"

@interface DynamicOptionsTableViewController : UITableViewController <OptionSelectDelegate>
@property(nonatomic, assign) NSArray *questions;
@property(nonatomic, strong) NSString* node;
@property(assign, nonatomic) id <OptionSelectDelegate> delegate;
@end
