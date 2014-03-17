//
//  OCMyImageView.m
//  Comics Maker
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 3/17/14.
//  Copyright (c) 2014 Emannuel Fernandes de Oliveira Carvalho. All rights reserved.
//

#import "OCMyImageView.h"

@implementation OCMyImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5);
    CGContextSetRGBStrokeColor(context, 0.7, 0.7, 0.7, 0.5);
    CGContextFillRect(context, rect);
}


@end
