//
//  RegistrationContainerViewController.m
//  roomcast
//
//  Created by Tom Lodge on 19/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "RegistrationContainerViewController.h"
#import "FormTableViewController.h"

@interface RegistrationContainerViewController ()

@end

@implementation RegistrationContainerViewController

@synthesize development;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"ok lovely %@", self.development);
    FormTableViewController *registrationform = (FormTableViewController*)[segue destinationViewController];
    
    NSLog(@"assigning development %@", self.development);
    
    
    registrationform.development = self.development;
}

@end
