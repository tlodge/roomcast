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
            Apartment* a = [apartments objectAtIndex:i];
            [self.delegate didSelectApartment:a withValue:NO];
        }
    }
    else{
        [self.selectToggle initWithCustomView:self.switchOn];
        
        for (int i = 0; i < [self.apartments count]; i++){
            Apartment* a = [apartments objectAtIndex:i];
            [self.delegate didSelectApartment:a withValue:YES];
            
        }
    }
    [self.tableView reloadData];
}

-(void) toggleSelect:(UISwitch*)sender{

    Apartment* a = [apartments objectAtIndex:sender.tag];
    [self.delegate didSelectApartment:a withValue:sender.on];
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
    static NSString *CellIdentifier = @"ApartmentCell";
    
    ApartmentCell *cell = (ApartmentCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Apartment *apartment = [apartments objectAtIndex:indexPath.row];
    
    if ([self.selections objectForKey:apartment.apartmentId] != nil){
        [cell.selectSwitch setOn:YES];
    }else{
        [cell.selectSwitch setOn:NO];
    }
    
    cell.selectSwitch.tag = indexPath.row;
    
    [cell.selectSwitch addTarget:self action:@selector(toggleSelect:)forControlEvents:UIControlEventValueChanged];
    
    if (apartment)
        cell.name.text = apartment.name;

    return cell;
}

@end
