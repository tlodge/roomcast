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

@interface FormTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *username;
- (IBAction)editStarted:(id)sender;

- (IBAction)usernameChanged:(id)sender;

- (IBAction)registerbutton:(id)sender;

@end
