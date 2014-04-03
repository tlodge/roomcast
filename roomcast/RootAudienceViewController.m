//
//  RootAudienceViewController.m
//  roomcast
//
//  Created by Tom Lodge on 25/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "RootAudienceViewController.h"

@interface RootAudienceViewController ()

@end

@implementation RootAudienceViewController

@synthesize scope;
@synthesize development;
@synthesize developments;
@synthesize totals;
@synthesize currentScope;
@synthesize filters;
@synthesize selectedFilters;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


/*
-(void) viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

-(void) viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}*/


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView{
    
    UITableViewCell*  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    // Configure the cell...
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}*/

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
 
 
 -(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
     NSString *segueName = segue.identifier;
 
     if ([segueName isEqualToString: @"destinationSegue"]){
         DestinationViewController* dvc = (DestinationViewController*) [segue destinationViewController];
         
         dvc.scopedelegate       = self;
         dvc.scope               = self.scope;
         dvc.totals              = self.totals;
         dvc.scopeTypes          = self.scopeTypes;
         dvc.developmentName     = self.development.name;
         dvc.developments        = self.developments;
         
         NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
         
         NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
         
         dvc.blocks = [[[self.development blocks] allObjects] sortedArrayUsingDescriptors:sortDescriptors];
         
     }else if ([segueName isEqualToString:@"filterSegue"]){
         FilterViewController* fvc = (FilterViewController*) [segue destinationViewController];
         fvc.filterdelegate = self;
         fvc.filters = self.filters;
         fvc.selectedFilters = self.selectedFilters;
         fvc.filterDescriptions = self.filterDescriptions;
     }
}

#pragma mark - Delegate methods

-(void) didSelectScope:(NSString*) scopeName withValues:(NSMutableArray*) scopeValues withSummary:(NSString*)summary{
    
    self.whoToSummaryLabel.text = summary;
    
    [self.scopedelegate didSelectScope:scopeName withValues:scopeValues withSummary:summary];
}

-(void) didSelectFilter:(NSString *)filterName{
    [self.filterdelegate didSelectFilter:filterName];
    self.filterSummaryLabel.text = [self.selectedFilters componentsJoinedByString:@","];
}

-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

@end
