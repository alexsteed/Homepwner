//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Alexis Bastide on 01/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNREditDateViewController.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@end

@implementation BNRDetailViewController

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // NSDateFormater that will turn the date into a simple date string
    NSDateFormatter *dateFormater = nil;
    if (!dateFormater)
    {
        dateFormater = [[NSDateFormatter alloc] init];
        dateFormater.dateStyle = NSDateFormatterMediumStyle;
        dateFormater.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate Object to set dateLabel contents
    [self.dateButton setTitle:[dateFormater stringFromDate:item.dateCreated] forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.valueField resignFirstResponder];
}

- (IBAction)startDateEditing:(id)sender
{
    BNREditDateViewController *editDateViewController = [[BNREditDateViewController alloc] init];
    editDateViewController.item = _item;
    [self.navigationController pushViewController:editDateViewController animated:YES];
}

@end
