//
//  FeedbackItemCell.h
//  roomcast
//
//  Created by Tom Lodge on 26/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FromView.h"

@interface FeedbackItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *feedbackImage;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet FromView *fromView;

@end
