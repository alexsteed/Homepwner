//
//  BNRItemCell.m
//  Homepwner
//
//  Created by Alexis Bastide on 25/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock)
    {
        self.actionBlock();
    }
}

@end
