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

@interface ChatViewController : UITableViewController <UITextViewDelegate>
- (IBAction)respondClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *respondButton;
-(void) chatID: (NSString *) chatID;
@property (weak, nonatomic) RespondView* respondView;
@property (strong, nonatomic) NSArray* messages;
@property(nonatomic, assign) BOOL composing;
@end
