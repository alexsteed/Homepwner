//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Alexis Bastide on 01/09/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()

<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If the device has a camera tale a photo, otherwise just pick
    // from the library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image photo info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store the image in BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    // Put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Take image picker off the the screen, you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewWillAppear:(BOOL)animated
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
    self.dateLabel.text = [dateFormater stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    
    // Get the image for its image key from the image store
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    // Use the image to put on the screen in the image view
    self.imageView.image = imageToDisplay;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameField.delegate = self;
    self.serialNumberField.delegate = self;
    self.valueField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backGroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

@end
