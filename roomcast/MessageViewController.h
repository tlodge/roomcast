//
//  MessageViewController.h
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "DetailViewController.h"

@interface MessageViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *messages;
@end
