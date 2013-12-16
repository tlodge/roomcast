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

@interface MessageViewController : UITableViewController <UITextViewDelegate, RespondDelegate, MessageScopeDelegate>

@property (weak, nonatomic) IBOutlet UIButton *composeButton;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSMutableArray *messages;//defunct??

- (IBAction)toggleMessage:(id)sender;
@property (nonatomic, strong) NSArray *conversations;
@property (strong, nonatomic) Conversation* selectedConversation;

@property(nonatomic, assign) BOOL composing;
@property (strong, nonatomic) MessageView* messageView;
@end
