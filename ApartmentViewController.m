//
//  ApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "ApartmentViewController.h"
#import "ApartmentCell.h"
@interface ApartmentViewController ()

@end

@implementation ApartmentViewController

@synthesize block;
@synthesize selections;
@synthesize apartments;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selections = [[NSMutableArray alloc] initWithCapacity:[block.apartments count]];
    
    for (int i = 0; i < [block.apartments count]; i++){
        [self.selections addObject: [NSNumber numberWithBool:YES]];
    }
    
    apartments = [block.apartments allObjects];
    
    /*dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        //this runs on background thread!
        BOOL success = [[DataManager sharedManager] syncWithBlock:block];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success){
                
                self.selections = [[NSMutableArray alloc] initWithCapacity:[block.apartments count]];
                
                for (int i = 0; i < [block.apartments count]; i++){
                    NSLog(@"adding object to selections");
                    [self.selections addObject: [NSNumber numberWithBool:YES]];
                }
                
                apartments = [block.apartments allObjects];
                [self.tableView reloadData];
            }
        });
    });*/

    self.switchOn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchOn setImage:[UIImage imageNamed:@"switchon.png"] forState:UIControlStateNormal];
    self.switchOn.frame=CGRectMake(0.0, 0.0, 53.0, 32.0);
    [self.switchOn addTarget:self action: @selector(toggleAllSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.switchOff = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchOff setImage:[UIImage imageNamed:@"switchoff.png"] forState:UIControlStateNormal];
    self.switchOff.frame=CGRectMake(0.0, 0.0, 53.0, 32.0);
    [self.switchOff addTarget:self action: @selector(toggleAllSelected:) forControlEvents:UIControlEventTouchUpInside];

    [self.selectToggle initWithCustomView:self.switchOff];
   
}

-(void) toggleAllSelected:(id) sender{
    if (sender == self.switchOn){
        [self.selectToggle initWithCustomView:self.switchOff];
       
        for (int i = 0; i < [self.apartments count]; i++){
           // [self.apartments setObject:[NSNumber numberWithBool:YES]
           //         atIndexedSubscript:i];
        }
        [self.tableView reloadData];
        return;
    }
    else{
        //what happens if update underlying button instead?
        [self.selectToggle initWithCustomView:self.switchOn];
        for (int i = 0; i < [self.apartments count]; i++){
            //[self.apartments setObject:[NSNumber numberWithBool:NO]
             //       atIndexedSubscript:i];
        }
        [self.tableView reloadData];
    }
}

-(void) toggleSelect:(UISwitch*)sender{
    NSLog(@"sender tag is %d and on is %@", sender.tag, [NSNumber numberWithBool:sender.on]);
    [self.selections setObject:[NSNumber numberWithBool:sender.on] atIndexedSubscript:sender.tag];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (apartments){
        return [apartments count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"REEEEELOADING THE DATA!!!!!!!!!!");
    NSLog(@"%@",self.selections);

    static NSString *CellIdentifier = @"ApartmentCell";
    
    ApartmentCell *cell = (ApartmentCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSNumber* status = (NSNumber*) [self.selections objectAtIndex:indexPath.row];
    
    [cell.selectSwitch setOn:[status boolValue]];
    
    cell.selectSwitch.tag = indexPath.row;
    
    [cell.selectSwitch addTarget:self action:@selector(toggleSelect:)forControlEvents:UIControlEventValueChanged];
    
    Apartment *apartment = [apartments objectAtIndex:indexPath.row];
    
    if (apartment)
        cell.name.text = apartment.name;

    return cell;
}

@end
