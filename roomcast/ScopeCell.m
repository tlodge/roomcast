//
//  ScopeCell.m
//  roomcast
//
//  Created by Tom Lodge on 25/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "ScopeCell.h"

@implementation ScopeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.selectedView setOpaque:FALSE];
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    NSLog(@"in set selected!!");
    self.selectedView.alpha = selected ? 1.0: 0.0;
    
    // Configure the view for the selected state
}

@end
