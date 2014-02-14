//
//  ButtonCell.m
//  roomcast
//
//  Created by Tom Lodge on 14/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _fillColor = [UIColor clearColor];
    }
    return self;
}

-(void) setFillColor:(UIColor*) fillColor{
    _fillColor = fillColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat lineWidth = 3.0;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetFillColor(ctx, CGColorGetComponents([_fillColor CGColor]));
    CGContextSetRGBStrokeColor(ctx, 255, 255, 255, 1.0);
    CGRect borderRect = CGRectInset(rect, lineWidth*0.5, lineWidth*0.5);
    CGContextFillEllipseInRect(ctx, rect);
    CGContextStrokeEllipseInRect(ctx, borderRect);
}


@end
