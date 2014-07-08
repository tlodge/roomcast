//
//  NotificationCell.h
//  roomcast
//
//  Created by Tom Lodge on 22/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FromView.h"

@interface NotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@property (weak, nonatomic) IBOutlet FromView *fromView;
@property (weak, nonatomic) IBOutlet UIImageView *fromImage;

@end
