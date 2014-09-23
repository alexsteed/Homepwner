//
//  BNRPopoverBackgroundView.m
//  Homepwner
//
//  Created by Alexis Bastide on 22/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRPopoverBackgroundView.h"

@implementation BNRPopoverBackgroundView

@synthesize arrowDirection = _arrowDirection;
@synthesize arrowOffset = _arrowOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blueColor];
        self.arrowDirection = UIPopoverArrowDirectionAny;
        self.arrowOffset = 7.0;
    }
    return self;
}

+ (UIEdgeInsets)contentViewInsets
{
    UIEdgeInsets edgeInsets = {3.0, 3.0, 3.0, 3.0};
    return edgeInsets;
}

+ (BOOL)wantsDefaultContentAppearance
{
    return NO;
}

+ (CGFloat)arrowBase
{
    return 1.0;
}

+ (CGFloat)arrowHeight
{
    return 1.0;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    return;
}

- (void)setArrowOffset:(CGFloat)arrowOffset
{
    _arrowOffset = arrowOffset;
    return;
}

@end
