//
//  ApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()
/*-(void) _incrementTotalForBlock:(NSString*) objectId;
-(void) _decrementTotalForBlock:(NSString*) objectId;*/
-(int) _totalForBlock:(NSString *) objectId;
@end

@implementation BlockViewController

@synthesize blocks;
@synthesize selectedBlock;
@synthesize selections;
//@synthesize apartmentdelegate;

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
    
    NSLog(@"setting totals for %@", b.objectId);
    
    cell.chosen.text = [NSString stringWithFormat:@"%d apartments", [self _totalForBlock:b.objectId]];
    
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
    RootApartmentViewController* avc = (RootApartmentViewController*) [segue destinationViewController];
 
    NSArray* blockapartments = [[DataManager sharedManager] apartmentsForBlock:selectedBlock.objectId];
    
    //avc.delegate   = self;
    //avc.apartments = blockapartments;
    //avc.objectId    = selectedBlock.objectId;
    //avc.selections = self.selections;
}

#pragma apartment selected delegate
-(void) didSelectApartment:(Apartment*)apartment withValue:(BOOL)value{
    if (value){
        //if already selected, do nothing
        if ([self.selections objectForKey:apartment.objectId] != nil)
            return;
        
        //[self _incrementTotalForBlock:selectedBlock.objectId];
        
        [self.selections setObject:[NSNumber numberWithBool:value] forKey:apartment.objectId];
    }else{
        //if already not selected, do nothing
        if ([self.selections objectForKey:apartment.objectId] == nil)
            return;
        //[self _decrementTotalForBlock:selectedBlock.objectId];
        [self.selections removeObjectForKey:apartment.objectId];
    }
    //pass event up the chain (if there has been a genuine change
   // [self.apartmentdelegate didSelectApartment:apartment withValue:value];
    [self.tableView reloadData];

}

-(int) _totalForBlock:(NSString *) objectId{
    NSArray* blockapartments = [[DataManager sharedManager] apartmentsForBlock:objectId];
    int total = 0;
    
    for (int i = 0; i < [blockapartments count]; i++){
        Apartment *a = [blockapartments objectAtIndex:i];
        if ([self.selections objectForKey:a.objectId] != nil){
            total += 1;
        }
    }
    return total;
}

@end
