//
//  DevelopmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 17/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DevelopmentViewController.h"

@interface DevelopmentViewController ()

@end

@implementation DevelopmentViewController

@synthesize blocks;
@synthesize developmentName;
@synthesize developmentdelegate;
@synthesize selections;
@synthesize aggregateSelect;
@synthesize totalSelected;

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
    self.title = @"select a block";
    self.totalSelected = 0;
    
    for (int i = 0; i < [self.blocks count]; i++){
        Block* b = [self.blocks objectAtIndex:i];
        if ([self.selections objectForKey:b.objectId] != nil){
            self.totalSelected += [b.residents intValue];
        }
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
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
    return [self.blocks count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DevelopmentBlockCell";
    DevelopmentBlockCell *cell = (DevelopmentBlockCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //special case for the first row
    if (indexPath.row == 0){
        cell.blockNameLabel.text = [NSString stringWithFormat:@"All of %@", self.developmentName];

        if ([self.selections count] == [self.blocks count]){
            cell.totalSelectedLabel.text = [NSString stringWithFormat:@"%d apartments",self.totalSelected];
            [cell.selectedSwitch setOn:YES];
        }
        else{
             cell.totalSelectedLabel.text = @"";
        }
    }
    else{
        Block *b = [self.blocks objectAtIndex:indexPath.row - 1];
        cell.blockNameLabel.text = b.name;
        
        if ([self.selections objectForKey:b.objectId] != nil){
             [cell.selectedSwitch setOn:YES];
            cell.totalSelectedLabel.text = [NSString stringWithFormat:@"%d apartments", [b.residents intValue]];

        }else{
            [cell.selectedSwitch setOn:NO];
            cell.totalSelectedLabel.text = @"";
        }
    }
    cell.selectedSwitch.tag = indexPath.row;
    // Configure the cell...
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)selectionChanged:(UISwitch*)sender {
  
    if (sender.tag == 0){
        totalSelected = 0;
        if (sender.on){
            
            for (int i = 0; i < [self.blocks count]; i++){
                Block *b = [self.blocks objectAtIndex:i];
                [self.selections setObject:[NSNumber numberWithBool:YES] forKey:b.objectId];
                totalSelected += [b.residents intValue];
            }
        }else{
            [self.selections removeAllObjects];
        }
        
        [self.developmentdelegate didSelectAllBlocks:sender.on];
    }else{
        Block* b = [blocks objectAtIndex:sender.tag-1];
        if (sender.on){
            [self.selections setObject:[NSNumber numberWithBool:YES] forKey:b.objectId];
            [self.developmentdelegate didSelectBlock:b withValue:sender.on];
            self.totalSelected += [b.residents intValue];
        }else{
            [self.selections removeObjectForKey:b.objectId];
            [self.developmentdelegate didSelectBlock:b withValue:sender.on];
            self.totalSelected -= [b.residents intValue];
        }
    }
    [self.tableView reloadData];
}
@end
