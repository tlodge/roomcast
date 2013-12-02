//
//  InitViewController.m
//  roomcast
//
//  Created by Tom Lodge on 06/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "InitViewController.h"
#import "MessageViewController.h"

@interface InitViewController ()

@end

@implementation InitViewController

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
-(void)viewDidAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        
        NSLog(@"registering for remote notifications!");
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        //load up developments...
        
        RootTabViewController *rtvc = [storyboard instantiateViewControllerWithIdentifier:@"registered"];
        [self presentViewController:rtvc animated:YES completion:nil];
    } else {
         [self performSegueWithIdentifier: @"newbie" sender: self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
