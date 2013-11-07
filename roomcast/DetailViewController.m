//
//  DetailViewController.m
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize  testLabel;
NSString *toSay = @"";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.testLabel.text = toSay;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setText: (NSString *) newText{
    toSay = newText;
}

@end
