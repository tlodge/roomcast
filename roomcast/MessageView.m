//
//  MessageView.m
//  roomcast
//
//  Created by Tom Lodge on 06/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

@synthesize backButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)sendMessage:(id)sender {
}
@end
