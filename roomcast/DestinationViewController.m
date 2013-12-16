//
//  DestinationViewController.m
//  roomcast
//
//  Created by Tom Lodge on 21/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()
-(NSString*) _apartment_text;
-(void) setSelected:(ScopeCell*) cell;
-(void) setDeselected:(ScopeCell*) cell;
@end

//should be dynamic, so could potentially add new scopes!

@implementation DestinationViewController

@synthesize lastIndex;
@synthesize apartmentScope;
@synthesize scopedelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.apartmentScope = [[NSMutableDictionary alloc] init];
    lastIndex = [NSIndexPath indexPathForItem:1 inSection:1];
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
        [self setDeselected:cell];
    }
    
    if (indexPath.row > 0){
        ScopeCell* cell = (ScopeCell*)[tableView cellForRowAtIndexPath:indexPath];
        [self setSelected:cell];
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
    
    if (lastIndex.row == indexPath.row){
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
        [self setSelected:cell];
        lastIndex = indexPath;
    }
    
    if (indexPath.row == 1){
        cell.title.text = @"specific apartment(s)";
        [cell.info setFont:[UIFont fontWithName:@"Trebuchet MS" size:24]];
        cell.info.text = [self _apartment_text];
        cell.total.text = [NSString stringWithFormat:@"%d", [self.apartmentScope count]];
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

-(NSString*) _apartment_text{
    NSArray *apartments = [self.apartmentScope allValues];
    return [[apartments valueForKey:@"name"]componentsJoinedByString:@","];
}

-(void)  triggerSegue:(id)sender{
    UIButton *clicked = (UIButton *) sender;
    
    if (lastIndex != nil){
        ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:lastIndex];
        [self setDeselected:cell];
     
        
    }
    
    NSIndexPath* currentIndex = [NSIndexPath indexPathForRow:clicked.tag inSection:0];
    ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:currentIndex];
    [self setSelected:cell];
   
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

-(void) setSelected:(ScopeCell*) cell{
    cell.background.image = [UIImage imageNamed:@"scopecellselected.png"];
    cell.total.alpha = 1.0;
    cell.contentView.alpha = 1.0;
    cell.info.alpha = 1.0;
}

-(void) setDeselected:(ScopeCell*) cell{
    cell.background.image = [UIImage imageNamed:@"scopecell.png"];
    cell.total.alpha = 0.0;
    cell.contentView.alpha = 0.5;
    cell.info.alpha = 0.0;

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if ([[segue identifier] isEqualToString:@"apartmentSegue"]){
        BlockViewController* bvc = (BlockViewController*) [segue destinationViewController];
        bvc.apartmentdelegate = self;
        bvc.selections = self.apartmentScope;
        //pass apartment objects down stack, else lost at each segue to bvc!
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma apartment selected delegate
-(void) didSelectApartment:(Apartment*)apartment withValue:(BOOL)value{
    if (value){
        [self.apartmentScope setObject:apartment forKey:apartment.apartmentId];
        NSMutableDictionary* scope = [NSMutableDictionary dictionary];
        [scope setObject:@"apartment" forKey:@"type"];
        [scope setObject:[self.apartmentScope allValues] forKey:@"scope"];
        [self.scopedelegate didSelectScope:scope]; //tell parent (MessageViewController) to update scope
    }else{
        [self.apartmentScope removeObjectForKey:apartment.apartmentId];
    }
    
   
}

@end
