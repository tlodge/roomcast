//
//  RootButtonOptionsViewController.h
//  roomcast
//
//  Created by Tom Lodge on 23/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonOptionsTableViewController.h"
#import "Button.h"
#import "ButtonPressProtocol.h"

@interface RootButtonOptionsViewController : UIViewController <UITextViewDelegate>
- (IBAction)sendClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *toAdd;
@property(nonatomic, weak) Button* button;
@property(nonatomic, assign) id <ButtonPressDelegate> delegate;
@end
