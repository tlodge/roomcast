//
//  DestinationViewController.m
//  roomcast
//
//  Created by Tom Lodge on 21/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()

@end

//should be dynamic, so could potentially add new scopes!

@implementation DestinationViewController

NSIndexPath *lastIndex = nil;

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (lastIndex){
        ScopeCell* cell = (ScopeCell*)[tableView cellForRowAtIndexPath:lastIndex];
        cell.background.image = [UIImage imageNamed:@"scopecell.png"];
        cell.total.alpha = 0.0;
    }
    
    if (indexPath.row > 0){
        ScopeCell* cell = (ScopeCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.background.image = [UIImage imageNamed:@"scopecellselected.png"];
        cell.total.alpha = 1.0;
    }
    
    lastIndex = indexPath;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0){
        return[tableView dequeueReusableCellWithIdentifier:@"InfoCell" forIndexPath:indexPath];
    }
    
    ScopeCell* cell =  (ScopeCell*)[tableView dequeueReusableCellWithIdentifier:@"ScopeCell" forIndexPath:indexPath];
    
    [cell.moreButton addTarget:self action:@selector(triggerSegue:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row == 1){
        cell.title.text = @"specific apartment(s)";
        [cell.info setFont:[UIFont fontWithName:@"Trebuchet MS" size:24]];
        cell.info.text = @"1,2,3,4";
        cell.total.text = @"3";
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
        lastIndex = indexPath;
        cell.background.image = [UIImage imageNamed:@"scopecellselected.png"];
        cell.total.alpha = 1.0;
        cell.moreButton.tag = indexPath.row;
    }else if (indexPath.row == 2){
        cell.title.text = @"within Burrells Wharf";
        cell.info.text = @"floor 3, Charthouse";
        cell.total.text = @"125";
        cell.moreButton.tag = indexPath.row;

    }else if (indexPath.row ==3){
        cell.title.text = @"across developments";
        cell.info.text = @"Burrells Wharf, Langbourne Place, Canary Riverside";
        cell.total.text = @"293";
        cell.moreButton.tag = indexPath.row;

    }else if (indexPath.row == 4){
        cell.title.text = @"across region";
        cell.info.text = @"within 5 miles of Burrells Wharf";
        cell.total.text = @"563";
        cell.moreButton.tag = indexPath.row;

    }
    
    return cell;
}

-(void)  triggerSegue:(id)sender{
    UIButton *clicked = (UIButton *) sender;
    
    if (lastIndex != nil){
        ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:lastIndex];
        cell.background.image = [UIImage imageNamed:@"scopecell.png"];
        cell.total.alpha = 0.0;
        
    }
    
    NSIndexPath* currentIndex = [NSIndexPath indexPathForRow:clicked.tag inSection:0];
    ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:currentIndex];
    cell.background.image = [UIImage imageNamed:@"scopecellselected.png"];
    cell.total.alpha = 1.0;
    
    lastIndex = currentIndex;
    
    
    NSString *segue = @"apartmentSegue";
    
    if (clicked.tag == 2){
       segue = @"withinDevelopmentSegue";
    }
    else if (clicked.tag == 3){
       segue = @"acrossDevelopmentSegue";
    }else if (clicked.tag == 4){
       segue = @"withinRegionSegue";
    }
    
    
    
    [self performSegueWithIdentifier:segue sender:self];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
        return 70.0;
    return 75.0;
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
