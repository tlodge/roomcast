//
//  ApartmentToolbar.m
//  roomcast
//
//  Created by Tom Lodge on 10/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "ApartmentToolbar.h"

@implementation ApartmentToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, 0,self.frame.size.height); //start at this point
    
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}


@end
