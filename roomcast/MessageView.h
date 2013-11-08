//
//  MessageView.h
//  roomcast
//
//  Created by Tom Lodge on 06/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *whotoButton;
@property (weak, nonatomic) IBOutlet UIButton *numberButton;
@property (weak, nonatomic) IBOutlet UITextView *messageView;
@end
