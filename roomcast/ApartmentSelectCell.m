//
//  ApartmentSelectCell.m
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "ApartmentSelectCell.h"

@interface ApartmentSelectCell()
@property(assign, nonatomic) BOOL highlighted;
@property(assign, nonatomic) int count;
@end

@implementation ApartmentSelectCell

@synthesize highlighted;
@synthesize count;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self) {
            //self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apartment_scope_selected.png"]];
            /*backgroundImageView.image = [UIImage imageNamed:@"background.png"];
            highlightImageView.image = [UIImage imageNamed:@"highlight.png"];
            self.backgroundView = backgroundImageView;
            _isHighlight = -1;*/
            self.count = 0;
            self.highlighted = NO;
        }
    }
    return self;
}


-(void) changeState{
    if (self.highlighted)
        self.highlighted = NO;
    else
        self.highlighted = YES;
    
    NSLog(@"changing state! %d", self.count);
    self.count +=1 ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
