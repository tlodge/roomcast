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

Development* development;

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
    self.developmentId.text = @"A1Ez8PPtXx";
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
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        //this runs on background thread!!!
        BOOL success = [[DataManager sharedManager] syncWithDevelopment:_developmentId.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success){
                [self performSegueWithIdentifier:@"authenticate" sender:self];
            }
        });
    });
}

-(IBAction)unwindToAuth:(UIStoryboardSegue*) unwindSegue{
    NSLog(@"niceley done!");
}


@end
