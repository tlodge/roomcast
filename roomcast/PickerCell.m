//
//  PickerCell.m
//  roomcast
//
//  Created by Tom Lodge on 31/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = self.contentView.frame.size;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(8.0,8.0,size.width-16.0, size.height-16.0)];
        [self.label setFont:[UIFont boldSystemFontOfSize:20.0]];
        [self.label setTextColor:[UIColor blueColor]];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
