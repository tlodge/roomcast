//
//  RootButtonOptionsViewController.h
//  roomcast
//
//  Created by Tom Lodge on 23/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Button.h"
#import "ButtonPressProtocol.h"
#import "DynamicOptionsTableViewController.h"
#import "OptionSelectedProtocol.h"

@interface ButtonSelectedViewController : UIViewController <UITextViewDelegate, OptionSelectDelegate>
- (IBAction)sendClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *toAdd;
@property(nonatomic, weak) Button* button;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, assign) id <ButtonPressDelegate> delegate;
@end
