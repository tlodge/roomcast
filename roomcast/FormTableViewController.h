//
//  FormTableViewController.h
//  roomcast
//
//  Created by Tom Lodge on 30/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface FormTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UIPickerView *block;
@property (weak, nonatomic) IBOutlet UIPickerView *floor;

@property (weak, nonatomic) IBOutlet UIButton *registerbutton;

@end
