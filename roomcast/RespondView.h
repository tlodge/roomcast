//
//  RespondView.h
//  roomcast
//
//  Created by Tom Lodge on 11/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespondView : UIControl
@property (weak, nonatomic) IBOutlet UIButton *respondButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextView *responseText;

@end
