//
//  DevelopmentsViewController.m
//  roomcast
//
//  Created by Tom Lodge on 08/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "DevelopmentsViewController.h"

@interface DevelopmentsViewController ()

@end

@implementation DevelopmentsViewController

@synthesize developments;

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
    [[NSNotificationCenter defaultCenter] addObserverForName:@"developmentsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
       
        NSLog(@"the developments are NOW %@", self.developments);
        [self.tableView reloadData];
    }];
    

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
    return [developments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DevelopmentCell";
    
    DevelopmentCell *cell = (DevelopmentCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Development* d = [developments objectAtIndex:indexPath.row];
    
    cell.name.text = d.name;
    cell.total.text = [NSString stringWithFormat:@"%d apartments", [d.residents integerValue]];
   
    if ([self.selections containsObject:d]){
        [cell.selectSwitch setOn:YES];
    }else{
        [cell.selectSwitch setOn:NO];
    }
    
    cell.selectSwitch.tag = indexPath.row;
    
    [cell.selectSwitch addTarget:self action:@selector(toggleSelect:)forControlEvents:UIControlEventValueChanged];
    // Configure the cell...
    
    return cell;
}

-(void) toggleSelect:(UISwitch*)sender{
    Development* d = [developments objectAtIndex:sender.tag];
    NSLog(@"development = toggling select!!!!!!");
    [self.developmentsdelegate didSelectDevelopment:d withValue:sender.on];
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

@end
