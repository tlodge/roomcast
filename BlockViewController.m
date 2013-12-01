//
//  ApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

@synthesize blocks;
@synthesize selectedBlock;

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
    
    Development* d = [[DataManager sharedManager] development];
    
    self.blocks = [[d blocks] allObjects];

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
    static NSString *CellIdentifier = @"BlockCell";
    BlockCell *cell =  (BlockCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Block* b = [self.blocks objectAtIndex:indexPath.row];
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
   // NSLog(@"seleceted block is %@", self.selectedBlock.name);
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ApartmentViewController* avc = (ApartmentViewController*) [segue destinationViewController];
    avc.delegate = self;
    
    //avc.selections = self.selections for block x
    //avc.apartments = self.apartment for block x

}

#pragma apartment selected delegate
-(void) didSelectApartment:(NSString*) apartmentId withValue:(BOOL)value{
    
}


/*

 self.selections = [[NSMutableArray alloc] initWithCapacity:[block.apartments count]];

 for (int i = 0; i < [block.apartments count]; i++){
    [self.selections addObject: [NSNumber numberWithBool:YES]];
 }

 apartments = [block.apartments allObjects];

 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
 
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

@end
