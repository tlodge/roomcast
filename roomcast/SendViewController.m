//
//  SendViewController.m
//  roomcast
//
//  Created by Tom Lodge on 06/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "SendViewController.h"

@interface SendViewController ()

@end

@implementation SendViewController

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
   
    
    // Custom initialization
   
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MessageView"
                                                         owner:self
                                                       options:nil];
    //I'm assuming here that your nib's top level contains only the view
    //you want, so it's the only item in the array.
    CGRect mainframe = [[UIScreen mainScreen] bounds];
    float width = mainframe.size.width;
    float height = mainframe.size.height;
    
    MessageView *aView = [nibContents objectAtIndex:0];
    //[aView.testButton addTarget:self action:@selector(attemptLogin)
    //forControlEvents:UIControlEventTouchUpInside];
    
    aView.frame = CGRectMake(0,height,width,200); //or whatever coordinates you need
    [self.view addSubview:aView];
    [UIView beginAnimations:@"SwitchToMessageView" context:nil];
    [UIView setAnimationDuration:0.5];
    aView.frame = CGRectMake(0,height-250,width,200);
    [UIView commitAnimations];

}
@end
