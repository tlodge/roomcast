//
//  ConversationCell.h
//  roomcast
//
//  Created by Tom Lodge on 13/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teaserLabel;
@property (weak, nonatomic) IBOutlet UILabel *scopeLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@property (weak, nonatomic) IBOutlet UILabel *sinceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *scopeImage;

@end
