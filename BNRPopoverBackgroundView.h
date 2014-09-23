//
//  BNRPopoverBackgroundView.h
//  Homepwner
//
//  Created by Alexis Bastide on 22/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRPopoverBackgroundView : UIPopoverBackgroundView

@property (nonatomic, readwrite) CGFloat arrowOffset;
@property (nonatomic, readwrite) UIPopoverArrowDirection arrowDirection;

@end
