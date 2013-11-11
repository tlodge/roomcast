//
//  LeftMessageCell.h
//  roomcast
//
//  Created by Tom Lodge on 10/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMessageCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tlc;
-(void) initWithMessage: (NSString *) message forHeight: (CGFloat) height;
@end
