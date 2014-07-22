//
//  StartViewController.h
//  roomcast
//
//  Created by Tom Lodge on 19/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AuthViewController.h"
#import "DataManager.h"

@interface StartViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *developmentId;
- (IBAction)lookupDevelopment:(id)sender;

-(IBAction)unwindToAuth:(UIStoryboardSegue*) unwindSegue;

@end
