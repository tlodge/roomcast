//
//  ChatViewController.h
//  roomcast
//
//  Created by Tom Lodge on 08/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MessageCell.h"
#import "Message.h"
#import "RespondView.h"

@protocol RespondDelegate;

@interface ChatViewController : UITableViewController <UITextViewDelegate>
- (IBAction)respondClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *respondButton;
-(void) chatID: (NSString *) chatID;
@property (strong, nonatomic) RespondView* respondView;
@property (strong, nonatomic) NSArray* messages;
@property(nonatomic, assign) BOOL composing;
@property(weak, nonatomic) NSString* conversationId;
@property(nonatomic, assign) id <RespondDelegate> delegate;
@end

@protocol RespondDelegate <NSObject>
// recipe == nil on cancel
-(void) didRespondToConversation:(NSString*) conversationId withMessage:(NSString*) message;

@end
