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
    self.apartments = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES], nil];
    self.switchOn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchOn setImage:[UIImage imageNamed:@"switchon.png"] forState:UIControlStateNormal];
    self.switchOn.frame=CGRectMake(0.0, 0.0, 53.0, 32.0);
    [self.switchOn addTarget:self action: @selector(toggleSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.switchOff = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchOff setImage:[UIImage imageNamed:@"switchoff.png"] forState:UIControlStateNormal];
    self.switchOff.frame=CGRectMake(0.0, 0.0, 53.0, 32.0);
    [self.switchOff addTarget:self action: @selector(toggleSelect:) forControlEvents:UIControlEventTouchUpInside];

    [self.selectToggle initWithCustomView:self.switchOff];
   
}

-(void) toggleSelect:(id) sender{
    if (sender == self.switchOn){
        [self.selectToggle initWithCustomView:self.switchOff];
       
        for (int i = 0; i < [self.apartments count]; i++){
            [self.apartments setObject:[NSNumber numberWithBool:YES]
                    atIndexedSubscript:i];
        }
        [self.tableView reloadData];
        
    }else{
        //what happens if update underlying button instead?
        [self.selectToggle initWithCustomView:self.switchOn];
        for (int i = 0; i < [self.apartments count]; i++){
            [self.apartments setObject:[NSNumber numberWithBool:NO]
                    atIndexedSubscript:i];
        }
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.apartments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ApartmentCell";
    ApartmentCell *cell = (ApartmentCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSNumber* status = (NSNumber*) [self.apartments objectAtIndex:indexPath.row];
    [cell.selectSwitch setOn:[status boolValue]];
    // Configure the cell...
    
    return cell;
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
