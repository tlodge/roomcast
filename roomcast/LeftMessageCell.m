//
//  LeftMessageCell.m
//  roomcast
//
//  Created by Tom Lodge on 10/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "LeftMessageCell.h"

@implementation LeftMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        imageView.image = [UIImage imageNamed:@"continue.png"];
        [self.contentView addSubview:imageView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
