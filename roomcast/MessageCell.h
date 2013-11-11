//
//  LeftMessageCell.h
//  roomcast
//
//  Created by Tom Lodge on 10/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
-(void) initWithMessage: (NSString *) message forHeight: (CGFloat) height forOriention: (NSInteger) orientation;
@end
