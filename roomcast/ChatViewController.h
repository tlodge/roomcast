//
//  ChatViewController.h
//  roomcast
//
//  Created by Tom Lodge on 08/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCell.h"
#import "Message.h"
#import "RespondView.h"
#import "Conversation.h"
#import "DataManager.h"
#import "RPCManager.h"

@protocol RespondDelegate;

@interface ChatViewController : UITableViewController <UITextViewDelegate>
- (IBAction)respondClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *respondButton;
@property (strong, nonatomic) RespondView* respondView;
@property (strong, nonatomic) NSArray* messages;
@property(nonatomic, assign) BOOL composing;
@property(nonatomic, strong) NSString *conversationId;
@property(nonatomic, assign) id <RespondDelegate> delegate;
@end

@protocol RespondDelegate <NSObject>
// recipe == nil on cancel
-(void) didRespondToConversation:(NSString*) conversationId withMessage:(NSString*) message;

@end
