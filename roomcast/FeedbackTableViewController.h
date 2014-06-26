//
//  FeedbackTableViewController.h
//  roomcast
//
//  Created by Tom Lodge on 26/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedbackItemCell.h"

@interface FeedbackTableViewController : UITableViewController
@property(nonatomic, strong) NSArray* images;
@property(nonatomic, strong) NSArray* labels;
@end
