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
    CGFloat padding = 5.0;
    
    CGRect buttonRect = CGRectMake(padding, padding, rect.size.width- (2*padding), rect.size.height-(2*padding));
    
    CGFloat lineWidth = 3.0;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, lineWidth);
    //CGContextSetFillColor(ctx, CGColorGetComponents([_fillColor CGColor]));
    CGContextSetFillColorWithColor(ctx, [UIColorAlphaFromRGB(0x201f1f) CGColor]);
    CGContextSetStrokeColorWithColor(ctx, [UIColorFromRGB(0xd48037) CGColor]);
    CGRect borderRect = CGRectInset(buttonRect, lineWidth*0.5, lineWidth*0.5);
    CGContextFillEllipseInRect(ctx, buttonRect);
    CGContextStrokeEllipseInRect(ctx, borderRect);
    
    CGRect labelRect = CGRectMake(0, rect.size.height / 2 - (30/2), rect.size.width, 30);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:labelRect cornerRadius:6.0];
    
    CGContextSetStrokeColorWithColor(ctx, [UIColorFromRGB(0x201f1f) CGColor]);
    
    CGContextSetFillColorWithColor(ctx, [UIColorFromRGB(0xd48037) CGColor]);
    [bezierPath fill];
    bezierPath.lineWidth = 3.0;
    [bezierPath stroke];
}


@end
