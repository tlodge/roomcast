//
//  FeedbackCell.m
//  roomcast
//
//  Created by Tom Lodge on 26/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "FeedbackCell.h"

@implementation FeedbackCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
