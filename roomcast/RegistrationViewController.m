//
//  RegistrationContainerViewController.m
//  roomcast
//
//  Created by Tom Lodge on 19/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()
-(void) updateFloorsForBlock:(Block*)block;
@end

@implementation RegistrationViewController

@synthesize  development;
@synthesize blockLabel;
@synthesize floorLabel;
@synthesize selectedBlock;
@synthesize  selectedFloor;

NSArray* blocks;
NSArray* floors;


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
    development = [[DataManager sharedManager] development];
    self.blockArray = [development.blocks allObjects];
    
    
    self.selectedBlock = [self.blockArray objectAtIndex:0];
    [self updateFloorsForBlock:self.selectedBlock];
    
   // NSString *floorString = self.selectedBlock.floors;
   // NSData *jsonFloors = [floorString dataUsingEncoding:NSUTF8StringEncoding];
    //NSError *error;
    
    //self.floorArray = [NSJSONSerialization JSONObjectWithData:  jsonFloors options: NSJSONReadingMutableContainers error:&error];
    
    
    //(NSArray*)[(PFObject*)[self.blockArray objectAtIndex:0] objectForKey:@"floors"];
    
    
    self.blockLabel.text = self.selectedBlock.name;
    
    [self updateFloorsForBlock:selectedBlock];
    
    self.username.delegate = self;
    self.username.enablesReturnKeyAutomatically = NO;
    self.password.delegate = self;
    self.password.enablesReturnKeyAutomatically = NO;
    self.apartment.delegate = self;
    self.apartment.enablesReturnKeyAutomatically = NO;
    
    self.email.delegate = self;
    self.email.enablesReturnKeyAutomatically = NO;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registerUser:(id)sender {
    
    PFUser *user = [PFUser user];
    user.username = _username.text;
    user.password = _password.text;
    user.email = _email.text;
    
    PFObject *abode = [PFObject objectWithClassName:@"Apartment"];
    
    PFObject *block = [PFObject objectWithoutDataWithClassName:@"Block" objectId:selectedBlock.objectId];
    
    PFObject *dev  =  [PFObject objectWithoutDataWithClassName:@"Development" objectId:development.objectId];
    
    
    [abode setObject:block forKey:@"block"];
    [abode setObject:selectedFloor forKey:@"floor"];
    [abode setObject:self.apartment.text forKey:@"name"];
    
    [user setObject:dev forKey:@"development"];
    [user setObject:block forKey:@"block"];
    [user setObject:abode forKey:@"apartment"];
   
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            
            [self performSegueWithIdentifier: @"messages" sender: self];
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
        }else{
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
}

#pragma textfield delegate method

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    textField.enablesReturnKeyAutomatically = NO;
    return YES;
    
}

#pragma  private methods
-(void) updateFloorsForBlock:(Block*)block{
    
    NSString *floorString = block.floors;
    
    NSData *jsonFloors = [floorString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    self.floorArray = [NSJSONSerialization JSONObjectWithData:  jsonFloors options: NSJSONReadingMutableContainers error:&error];
    
    self.selectedFloor = [self.floorArray objectAtIndex:0];
    self.floorLabel.text = self.selectedFloor;
    
}

#pragma delegate methods

-(void) didSelectFloor:(NSString*) floor{
    self.selectedFloor = floor;
    self.floorLabel.text = self.selectedFloor;
}

-(void) didSelectBlock:(Block*) block{
    if ([selectedBlock.name isEqualToString:block.name])
        return;
    self.selectedBlock = block;
    self.blockLabel.text = self.selectedBlock.name;
    [self updateFloorsForBlock:selectedBlock];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"registerblock"]){
        RegistrationBlockViewController* rbvc = (RegistrationBlockViewController*) [segue destinationViewController];
        rbvc.blocks = self.blockArray;
        rbvc.delegate = self;
    }
    
    if ([[segue identifier] isEqualToString:@"registerfloor"]){
        RegistrationFloorViewController* rfvc = (RegistrationFloorViewController*) [segue destinationViewController];
        rfvc.floors = self.floorArray;
        rfvc.delegate = self;
    }
}




@end
