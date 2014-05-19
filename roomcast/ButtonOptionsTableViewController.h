//
//  ButtonOptionsTableViewController.h
//  roomcast
//
//  Created by Tom Lodge on 23/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonOptionsCell.h"
#import "Button.h"

@interface ButtonOptionsTableViewController : UITableViewController
    @property(nonatomic, weak) Button* button;
@end
