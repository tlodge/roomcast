//
//  NotificationViewController.h
//  roomcast
//
//  Created by Tom Lodge on 22/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notification.h"
#import "DataManager.h"
#import "NotificationCell.h"
#import "FeedbackCell.h"
#import "RootFeedbackController.h"

@interface NotificationViewController : UITableViewController
@property(nonatomic, strong) NSArray* notifications;
@property(nonatomic, strong) UIRefreshControl* refreshControl;
@property(nonatomic, strong) NSDateFormatter* formatter;
@property(nonatomic, strong) NSDictionary* colours;
@end
