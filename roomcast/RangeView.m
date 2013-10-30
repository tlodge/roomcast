//
//  rangeView.m
//  roomcast
//
//  Created by Tom Lodge on 25/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "RangeView.h"

@implementation RangeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.circleColor = [UIColor redColor];
    }
    return self;
}

-(void) updateColor:(UIColor*) colour{
    self.circleColor = [UIColor blueColor];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"in draw rect");
    CGRect borderRect = CGRectInset(rect, 3, 3);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetFillColor(context, CGColorGetComponents([self.circleColor CGColor]));
    CGContextSetLineWidth(context, 3.0);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);
    CGContextFillPath(context);
}


@end
