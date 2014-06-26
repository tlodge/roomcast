//
//  RootFeedbackController.m
//  roomcast
//
//  Created by Tom Lodge on 26/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "RootFeedbackController.h"

@interface RootFeedbackController ()

@end

@implementation RootFeedbackController

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
    self.rating = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didSelectRating:(int) r{
    NSLog(@"seen a rating selected as %d", r);
    self.rating = r;
   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    FeedbackTableViewController* fvc = (FeedbackTableViewController*) [segue destinationViewController];
        
    fvc.delegate = self;
    
    
}


- (IBAction)sendPressed:(id)sender {
    NSLog(@"send pressed and rating is %d", self.rating);
    [[DataManager sharedManager] setRatingFor:self.notificationId withValue:self.rating];
}
@end
