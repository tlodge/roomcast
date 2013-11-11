//
//  LeftMessageCell.m
//  roomcast
//
//  Created by Tom Lodge on 10/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

float height = 44;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        

    }
    return self;
}

-(void) initWithMessage: (NSString *) message forHeight:(CGFloat) height forOriention:(NSInteger)orientation{
    
    UIImageView* imageView;
    UILabel *myMessageLabel;
    

    if (orientation == 0){
        myMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 15, 155, height-20)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, height)];
        imageView.image = [[UIImage imageNamed:@"bubble.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,20,27,20) resizingMode:UIImageResizingModeTile];
    }else{
        myMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 15, 155, height-20)];
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 180, height)];
        imageView.image = [[UIImage imageNamed:@"bubble_r.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,20,27,20) resizingMode:UIImageResizingModeTile];
    }
    [self.contentView addSubview:imageView];
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
