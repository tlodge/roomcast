//
//  SendRootViewController.m
//  roomcast
//
//  Created by Tom Lodge on 21/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "SendRootViewController.h"

@interface SendRootViewController ()

@end

@implementation SendRootViewController

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
    self.title = @"send a message";
   

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPressed:(id)sender {
}

/*
 *Note that for embedded seques, this is called before the parent (i.e this view controller's viewDidLoad method.  So any setup has to be done in the
    prepareForSegue of the calling controller..
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
}

#pragma -- delegate methods

-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

@end
