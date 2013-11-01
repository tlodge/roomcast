//
//  FormTableViewController.m
//  roomcast
//
//  Created by Tom Lodge on 30/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "FormTableViewController.h"

@interface FormTableViewController ()

@end

@implementation FormTableViewController

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
    
    /*[self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"CustomCell"];
    
    [self.tableView registerClass:[PassCell class] forCellReuseIdentifier:@"PassCell"];
    
    [self.tableView registerClass:[PickerCell class] forCellReuseIdentifier:@"PickerCell"];*/
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
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 2;
    if (section == 1)
        return 1;
    if (section == 2)
        return 3;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView{
    
    UITableViewCell*   cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)editStarted:(id)sender {
    NSLog(@"cooking!!");
}

- (IBAction)usernameChanged:(id)sender{
    NSLog(@"user name changed!!");
}
//If you are going with Custom Static Cells just comment this method:

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellIdentifier = @"notificationCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    return cell;
//}

//and give the cells an identifier at "Attributes Inspector" in storyboard.

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        if (indexPath.row == 0){
            
          
            CustomCell * cell =  (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
        
            cell.label.text = @"y";
            return cell;
        }
        PassCell * cell =  (PassCell *) [tableView dequeueReusableCellWithIdentifier:@"PassCell" forIndexPath:indexPath];
        return cell;
    }
    
    if (indexPath.section == 1){
        CustomCell * cell =  (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
        [cell.label setText:@"x"];
        return cell;
    }
    if (indexPath.section == 2){
        if (indexPath.row == 0 || indexPath.row == 3){
            PickerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PickerCell" forIndexPath:indexPath];
            cell.label.text = @"pick something!";
            return cell;
        }
        CustomCell * cell =  (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
        [cell.label setText:@"z"];
        
        return cell;
    }
    
    return nil;
}*/



- (IBAction)registerbutton:(id)sender{
    NSLog(@"nice!!");
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

- (IBAction)register:(id)sender {
}
@end
