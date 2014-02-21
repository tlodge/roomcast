//
//  MessageViewController.h
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#import "MessageView.h"
#import "ChatViewController.h"
#import "DestinationViewController.h"
#import <Parse/Parse.h>
#import "Development.h"
#import "DataManager.h"
#import "Apartment.h"
#import "ConversationCell.h"
#import "SendRootViewController.h"

@interface MessageViewController : UITableViewController <UITextViewDelegate, RespondDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSArray *conversations;
@property (strong, nonatomic) Conversation* selectedConversation;
@property (nonatomic, assign) BOOL composing;
@property (nonatomic, strong) NSDictionary *scopelabels;
@property (nonatomic, strong) Development *development;
@end
