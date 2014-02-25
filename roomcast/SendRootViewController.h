//
//  SendRootViewController.h
//  roomcast
//
//  Created by Tom Lodge on 21/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SendRootViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *sendText;
@property (weak, nonatomic) IBOutlet UILabel *audienceCount;
- (IBAction)sendPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelPressed;
@end
