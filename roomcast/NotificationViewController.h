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

@interface NotificationViewController : UITableViewController
@property(nonatomic, strong) NSArray* notifications;
@end
