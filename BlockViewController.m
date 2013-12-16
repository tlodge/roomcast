//
//  ApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()
-(void) _incrementTotalForBlock:(NSString*) blockId;
-(void) _decrementTotalForBlock:(NSString*) blockId;
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
    NSLog(@"I appeared!");
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Development* d = [[DataManager sharedManager] development];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.blocks = [[[d blocks] allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    //self.selections = [[NSMutableDictionary alloc] init];
    self.totals = [[NSMutableDictionary alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSLog(@"reloading cells!");
    static NSString *CellIdentifier = @"BlockCell";
    BlockCell *cell =  (BlockCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Block* b = [self.blocks objectAtIndex:indexPath.row];
    
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
    NSLog(@"seleceted block is %@", self.selectedBlock.name);
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ApartmentViewController* avc = (ApartmentViewController*) [segue destinationViewController];
 
    avc.delegate = self;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        //this runs on background thread!
        BOOL success = [[DataManager sharedManager] syncWithBlock:selectedBlock];
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (success){
                NSArray* blockapartments = [[selectedBlock.apartments allObjects] sortedArrayUsingDescriptors:sortDescriptors];
                avc.apartments = blockapartments;
                [avc.tableView reloadData];
            }
        });
    });
    
    NSArray* blockapartments = [[selectedBlock.apartments allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    avc.apartments = blockapartments;
    avc.selections = self.selections;
}

#pragma apartment selected delegate
-(void) didSelectApartment:(Apartment*)apartment withValue:(BOOL)value{
    if (value){
        //if already selected, do nothing
        if ([self.selections objectForKey:apartment.apartmentId] != nil)
            return;
        
        [self _incrementTotalForBlock:selectedBlock.blockId];
        
        [self.selections setObject:[NSNumber numberWithBool:value] forKey:apartment.apartmentId];
    }else{
        //if already not selected, do nothing
        if ([self.selections objectForKey:apartment.apartmentId] == nil)
            return;
        [self _decrementTotalForBlock:selectedBlock.blockId];
        [self.selections removeObjectForKey:apartment.apartmentId];
    }
    //pass event up the chain (if there has been a genuine change
    [self.apartmentdelegate didSelectApartment:apartment withValue:value];
}

-(void) _incrementTotalForBlock:(NSString*) blockId{
    NSNumber* total = [self.totals objectForKey:selectedBlock.blockId];
    
    if (total == nil){
        [self.totals setObject:[NSNumber numberWithInt:1] forKey:selectedBlock.blockId];
    }
    else{
        [self.totals setObject:[NSNumber numberWithInt:[total intValue] + 1]forKey:selectedBlock.blockId];
    }
}

-(void) _decrementTotalForBlock:(NSString*) blockId{
    NSNumber* total = [self.totals objectForKey:selectedBlock.blockId];
    if (total != nil){
        [self.totals setObject:[NSNumber numberWithInt:[total intValue] - 1]forKey:selectedBlock.blockId];
    }
}

-(int) _totalForBlock:(NSString *) blockId{
     NSNumber* total = [self.totals objectForKey:blockId];
    if (total != nil)
        return [total intValue];
    return 0;
}

@end
