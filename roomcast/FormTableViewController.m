//
//  FormTableViewController.m
//  roomcast
//
//  Created by Tom Lodge on 30/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "FormTableViewController.h"
#import "AppDelegate.h"

@interface FormTableViewController ()
-(void) updateFloorsForBlock:(Block*)block;
@end

@implementation FormTableViewController

@synthesize  development;

NSArray* blocks;
NSArray* floors;
Block* selectedBlock;
NSString* selectedFloor;

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
    
    development = [[DataManager sharedManager] development];
    self.blockArray = [development.blocks allObjects];
    
    
    NSLog(@"block array is %@", self.blockArray);
    
    Block *b = (Block *)[self.blockArray objectAtIndex:0];
    
    [self updateFloorsForBlock:b];
    
    NSString *floorString = b.floors;
    NSData *jsonFloors = [floorString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    
    self.floorArray = [NSJSONSerialization JSONObjectWithData:  jsonFloors options: NSJSONReadingMutableContainers error:&error];
    
    
    //(NSArray*)[(PFObject*)[self.blockArray objectAtIndex:0] objectForKey:@"floors"];
    
    selectedBlock = [self.blockArray objectAtIndex:0];
    
    NSLog(@"currently selected block is %@", selectedBlock);
    
    selectedFloor = [self.floorArray objectAtIndex:0];
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    self.username.delegate = self;
    self.username.enablesReturnKeyAutomatically = NO;
    self.password.delegate = self;
    self.password.enablesReturnKeyAutomatically = NO;
    self.apartment.delegate = self;
    self.apartment.enablesReturnKeyAutomatically = NO;

    self.email.delegate = self;
    self.email.enablesReturnKeyAutomatically = NO;

    self.blockpicker.delegate = self;
    self.floorpicker.delegate = self;
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
    textField.enablesReturnKeyAutomatically = NO;
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
        Block *block = [self.blockArray objectAtIndex:row];
        label.text = block.name;
    }
    if (pickerView == self.floorpicker){
        label.text = [self.floorArray objectAtIndex:row];
    }
    return label;
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
      if (pickerView == self.blockpicker){
          selectedBlock = [self.blockArray objectAtIndex:row];
          [self updateFloorsForBlock:selectedBlock];
          [self.floorpicker reloadAllComponents];
      }
      else if(pickerView == self.floorpicker){
          selectedFloor = [self.floorArray objectAtIndex:row];
      }
    
}

- (IBAction)registerUser:(id)sender {
    
    PFUser *user = [PFUser user];
    user.username = _username.text;
    user.password = _password.text;
    user.email = _email.text;
    
    PFObject *abode = [PFObject objectWithClassName:@"Apartment"];
    
    PFObject *block =[PFObject objectWithoutDataWithClassName:@"Block" objectId:selectedBlock.blockId];
    
    [abode setObject:block forKey:@"block"];
    [abode setObject:selectedFloor forKey:@"floor"];
    [abode setObject:self.apartment.text forKey:@"name"];
    [user setObject:abode forKey:@"apartment"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error){
            
            [self performSegueWithIdentifier: @"messages" sender: self];
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
        }else{
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"%@",errorString);
        }
    }];
}
                
                
#pragma  private methods
-(void) updateFloorsForBlock:(Block*)block{
    
    NSString *floorString = block.floors;
    
    NSData *jsonFloors = [floorString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    self.floorArray = [NSJSONSerialization JSONObjectWithData:  jsonFloors options: NSJSONReadingMutableContainers error:&error];
    
}
                
@end
