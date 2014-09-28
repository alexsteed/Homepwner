//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by Alexis Bastide on 26/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageViewController.h"

@implementation BNRImageViewController

- (void)loadView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // We must cast the view to UIImageView so the compiler knows it is ok to send the setImage
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
}

@end
