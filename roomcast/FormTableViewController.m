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
        [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor whiteColor]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    self.username.delegate = self;
    self.password.delegate = self;
    self.apartment.delegate = self;
    self.email.delegate = self;
    
    self.blockpicker.delegate = self;
    
    self.floorpicker.delegate = self;
    
    self.blockArray = [[NSArray alloc] initWithObjects:@"block1", @"block2", @"block3",nil];
    
    self.floorArray = [[NSArray alloc] initWithObjects:@"ground", @"1", @"2", @"3",nil];
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
        return 5;
    return 4;
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

#pragma textfield delegate method

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;

}

#pragma picker delegate methods

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.blockpicker){
         return [self.blockArray count];
    }
    if (pickerView == self.floorpicker){
        return [self.floorArray count];
    }
    return 0;
}

/*
-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   
}*/

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 37)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Trebuchet MS" size:18.0]];
    
    
    if (pickerView == self.blockpicker){
        label.text = [self.blockArray objectAtIndex:row];
    }
    if (pickerView == self.floorpicker){
        label.text = [self.floorArray objectAtIndex:row];
    }
    return label;
}



@end