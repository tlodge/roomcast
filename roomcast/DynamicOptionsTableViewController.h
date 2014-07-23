//
//  DynamicOptionsTableViewController.h
//  roomcast
//
//  Created by Tom Lodge on 22/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionSelectedProtocol.h"
#import "DynamicDefaultCell.h"
#import "DynamicSwitchCell.h"
#import "DynamicTextCell.h"

@interface DynamicOptionsTableViewController : UITableViewController <OptionSelectDelegate, UITextFieldDelegate>
@property(nonatomic, assign) NSArray *questions;
@property(nonatomic, strong) NSString* node;
@property(assign, nonatomic) id <OptionSelectDelegate> delegate;
@end
