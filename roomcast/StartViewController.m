//
//  StartViewController.m
//  roomcast
//
//  Created by Tom Lodge on 19/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

PFObject *development;

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
    _developmentId.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma textfield delegate method

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

- (IBAction)lookupDevelopment:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Development"];
    [query includeKey:@"blocks"];
    
    [query getObjectInBackgroundWithId:_developmentId.text block:^(PFObject *object, NSError *error) {
        development = object;
        if (error){
            NSLog(@"error!! %@ %@", error, [error userInfo]);
        }else{
            NSLog(@"the development is %@", development);
            [self performSegueWithIdentifier:@"authenticate" sender:self];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AuthViewController* auth = (AuthViewController*)[segue destinationViewController];
    auth.development = development;
}

@end
