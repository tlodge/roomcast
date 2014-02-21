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

@synthesize TYPES;
@synthesize scope;
@synthesize development;
@synthesize developments;
@synthesize totals;
@synthesize currentScope;

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
   
    //self.development  = [[DataManager sharedManager] development];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"developmentsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSLog(@"seen a developments update from network, so refetching from core data for development %@", self.development);
        self.developments = [[DataManager sharedManager] neighboursForDevelopment:self.development.objectId];
        
    }];

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
  
    
    NSString *segueName = segue.identifier;
    
    if ([segueName isEqualToString: @"destinationSegue"]){
        
        NSLog(@"ok am in here!!");
        
        DestinationViewController* destination = (DestinationViewController*) [segue destinationViewController];
        
        destination.scopedelegate       = self;
        destination.scope               = self.scope;
        destination.totals              = self.totals;
        destination.scopeTypes          = self.TYPES;
        NSLog(@"destaination scope types = %@", self.TYPES);
        
        destination.developmentName     = self.development.name;
        NSLog(@"development name is %@", self.development.name);
        
        destination.developments        = self.developments;
        NSLog(@"developments are %@", destination.developments);
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        destination.blocks = [[[self.development blocks] allObjects] sortedArrayUsingDescriptors:sortDescriptors];

    }
}

#pragma -- delegate methods

-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

-(void) didSelectScope:(NSString*) scopeName withValues:(NSDictionary*) scopeValues{
    
    self.currentScope = scopeName;
    
    [self.scope setObject:scopeValues forKey: scopeName];
    
    self.audienceCount.text = [NSString stringWithFormat:@"%d", [[self.totals objectForKey:scopeName] intValue]];
}

@end
