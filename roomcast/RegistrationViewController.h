//
//  RegistrationContainerViewController.h
//  roomcast
//
//  Created by Tom Lodge on 19/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Development.h"
#import "Block.h"
#import "DataManager.h"

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *email;

@property (weak, nonatomic) IBOutlet UITextField *apartment;

@property (strong, nonatomic) NSArray *blockArray;

@property (strong, nonatomic) NSArray *floorArray;

@property (weak, nonatomic) IBOutlet UILabel *blockLabel;

@property (weak, nonatomic) IBOutlet UILabel *floorLabel;

- (IBAction)registerUser:(id)sender;

@property (weak, nonatomic) Development* development;

@end
