//
//  FromView.m
//  roomcast
//
//  Created by Tom Lodge on 08/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "FromView.h"

@implementation FromView

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
    CGFloat lineWidth = 2.0;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, lineWidth);
    
    CGContextSetFillColorWithColor(ctx, [_fillColor CGColor]);
    CGContextSetStrokeColorWithColor(ctx, [UIColorFromRGB(0xffffff) CGColor]);
    CGRect borderRect = CGRectInset(rect, lineWidth*0.5, lineWidth*0.5);
    CGContextFillEllipseInRect(ctx, rect);
    CGContextStrokeEllipseInRect(ctx, borderRect);
     
}


@end
