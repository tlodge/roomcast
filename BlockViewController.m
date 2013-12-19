//
//  ApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()
/*-(void) _incrementTotalForBlock:(NSString*) blockId;
-(void) _decrementTotalForBlock:(NSString*) blockId;*/
-(int) _totalForBlock:(NSString *) blockId;
@end

@implementation BlockViewController

@synthesize blocks;
@synthesize selectedBlock;
@synthesize selections;
@synthesize apartmentdelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
   // [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.blocks count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BlockCell";
    BlockCell *cell =  (BlockCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Block* b = [self.blocks objectAtIndex:indexPath.row];
    
    NSLog(@"setting totals for %@", b.blockId);
    
    cell.chosen.text = [NSString stringWithFormat:@"%d", [self _totalForBlock:b.blockId]];
    
    cell.moreButton.tag = indexPath.row;
    [cell.moreButton addTarget:self action:@selector(triggerSegue:) forControlEvents:UIControlEventTouchUpInside];
    cell.name.text = b.name;
    
    return cell;
}

-(void)  triggerSegue:(id)sender{

    UIButton *clicked = (UIButton *) sender;
    self.selectedBlock = [self.blocks objectAtIndex:clicked.tag];
    [self performSegueWithIdentifier:@"selectApartments" sender:self];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedBlock = [self.blocks objectAtIndex:indexPath.row];
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ApartmentViewController* avc = (ApartmentViewController*) [segue destinationViewController];
 
    NSArray* blockapartments = [[DataManager sharedManager] apartmentsForBlock:selectedBlock.blockId];
    
    avc.delegate   = self;
    avc.apartments = blockapartments;
    avc.blockId    = selectedBlock.blockId;
    avc.selections = self.selections;
}

#pragma apartment selected delegate
-(void) didSelectApartment:(Apartment*)apartment withValue:(BOOL)value{
    if (value){
        //if already selected, do nothing
        if ([self.selections objectForKey:apartment.apartmentId] != nil)
            return;
        
        //[self _incrementTotalForBlock:selectedBlock.blockId];
        
        [self.selections setObject:[NSNumber numberWithBool:value] forKey:apartment.apartmentId];
    }else{
        //if already not selected, do nothing
        if ([self.selections objectForKey:apartment.apartmentId] == nil)
            return;
        //[self _decrementTotalForBlock:selectedBlock.blockId];
        [self.selections removeObjectForKey:apartment.apartmentId];
    }
    //pass event up the chain (if there has been a genuine change
    [self.apartmentdelegate didSelectApartment:apartment withValue:value];
    [self.tableView reloadData];

}

-(int) _totalForBlock:(NSString *) blockId{
    NSArray* blockapartments = [[DataManager sharedManager] apartmentsForBlock:blockId];
    int total = 0;
    
    for (int i = 0; i < [blockapartments count]; i++){
        Apartment *a = [blockapartments objectAtIndex:i];
        if ([self.selections objectForKey:a.apartmentId] != nil){
            total += 1;
        }
    }
    return total;
}

@end
