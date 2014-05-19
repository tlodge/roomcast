//
//  RootButtonOptionsViewController.m
//  roomcast
//
//  Created by Tom Lodge on 23/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "RootButtonOptionsViewController.h"

@interface RootButtonOptionsViewController ()

@end

@implementation RootButtonOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toAdd.returnKeyType = UIReturnKeyDone;
    [self.toAdd setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendClicked:(id)sender {
   [self.delegate didPressButton:self.button];
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -- delegate methods


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ButtonOptionsTableViewController* botvc = (ButtonOptionsTableViewController*) [segue destinationViewController];
    
    botvc.button = self.button;
    
}




@end
