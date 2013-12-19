//
//  RootTabViewController.m
//  roomcast
//
//  Created by Tom Lodge on 27/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "RootTabViewController.h"
#import "MessageViewController.h"

@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     NSLog(@"initing here");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"initing here");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDelegate:self];
    
    //load up the development here!
    
	// Do any additional setup after loading the view.
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
  
    if ([viewController isKindOfClass:[MessageViewController class]]){
        NSLog(@"Segue to message view controller");
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
