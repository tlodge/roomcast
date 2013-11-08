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
#import "MessageView.h"
#import "DestinationViewController.h"

@interface MessageViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *messages;

- (IBAction)sendMessage:(id)sender;

@end
