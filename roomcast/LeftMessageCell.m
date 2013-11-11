//
//  LeftMessageCell.m
//  roomcast
//
//  Created by Tom Lodge on 10/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "LeftMessageCell.h"

@implementation LeftMessageCell

float height = 44;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        

    }
    return self;
}

-(void) initWithMessage: (NSString *) message forHeight:(CGFloat) height{
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, height)];
    
    imageView.image = [[UIImage imageNamed:@"bubble.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,20,27,20) resizingMode:UIImageResizingModeTile];
    
    [self.contentView addSubview:imageView];

    UILabel *myMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 155, height-20)];
    [myMessageLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:14]];
    myMessageLabel.textColor = [UIColor whiteColor];
    myMessageLabel.text = message;
    myMessageLabel.numberOfLines = 6;
    [myMessageLabel sizeToFit];
    [self.contentView addSubview:myMessageLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
