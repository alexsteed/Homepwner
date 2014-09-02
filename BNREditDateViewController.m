//
//  BNREditDateViewController.m
//  Homepwner
//
//  Created by Alexis Bastide on 01/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNREditDateViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNREditDateViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNREditDateViewController

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = @"Edit creation date";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    BNRItem *item = self.item;
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.date = item.dateCreated;
}

- (IBAction)editDate:(id)sender
{
    NSDate *date = self.datePicker.date;
    BNRItem *item = self.item;
    item.dateCreated = date;
    NSLog(@"editing done %@", item.dateCreated);
}

@end
