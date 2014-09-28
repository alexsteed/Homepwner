//
//  BNRItemsViewController.h
//  Homepwner
//
//  Created by Alexis Bastide on 21/08/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRItemsViewController : UITableViewController <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *imagePopover;

@end
