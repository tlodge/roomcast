//
//  ConversationCell.m
//  roomcast
//
//  Created by Tom Lodge on 13/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "ConversationCell.h"

@implementation ConversationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
