//
//  FormTableViewController.h
//  roomcast
//
//  Created by Tom Lodge on 30/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "PassCell.h"
#import "PickerCell.h"
#import <Parse/Parse.h>

@interface FormTableViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *apartment;
@property (weak, nonatomic) IBOutlet UIPickerView *blockpicker;

@property (weak, nonatomic) IBOutlet UIPickerView *floorpicker;

@property (strong, nonatomic) NSArray *blockArray;

@property (strong, nonatomic) NSArray *floorArray;

- (IBAction)registerUser:(id)sender;


@end
