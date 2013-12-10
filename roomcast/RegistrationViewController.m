//
//  RegistrationContainerViewController.m
//  roomcast
//
//  Created by Tom Lodge on 19/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "RegistrationViewController.h"
#import "FormTableViewController.h"

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
    
    
    NSLog(@"block array is %@", self.blockArray);
    
    self.selectedBlock = [self.blockArray objectAtIndex:0];
    [self updateFloorsForBlock:self.selectedBlock];
    
    NSString *floorString = self.selectedBlock.floors;
    NSData *jsonFloors = [floorString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    self.floorArray = [NSJSONSerialization JSONObjectWithData:  jsonFloors options: NSJSONReadingMutableContainers error:&error];
    
    
    //(NSArray*)[(PFObject*)[self.blockArray objectAtIndex:0] objectForKey:@"floors"];
    
    
    self.blockLabel.text = self.selectedBlock.name;
    NSLog(@"currently selected block is %@", self.selectedBlock);
    
    selectedFloor = [self.floorArray objectAtIndex:0];
    
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
    
    PFObject *block =[PFObject objectWithoutDataWithClassName:@"Block" objectId:selectedBlock.blockId];
    
    [abode setObject:block forKey:@"block"];
    [abode setObject:selectedFloor forKey:@"floor"];
    [abode setObject:self.apartment.text forKey:@"name"];
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
    
}

#pragma delegate methods

-(void) didSelectFloor:(NSString*) floor{
    self.selectedFloor = floor;
    self.floorLabel.text = self.selectedFloor;
}

-(void) didSelectBlock:(Block*) block{
    NSLog(@"block %@ has been selected", block.name);
    self.selectedBlock = block;
    self.blockLabel.text = self.selectedBlock.name;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"preparing for segue!!!");
    
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
   /* if ([[segue identifier] isEqualToString:@"apartmentSegue"]){
        BlockViewController* bvc = (BlockViewController*) [segue destinationViewController];
        bvc.delegate = self;
        bvc.selections = self.apartmentScope;
        //pass apartment objects down stack, else lost at each segue to bvc!
    }*/
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




@end
