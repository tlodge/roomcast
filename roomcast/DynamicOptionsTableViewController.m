//
//  DynamicOptionsTableViewController.m
//  roomcast
//
//  Created by Tom Lodge on 22/07/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "DynamicOptionsTableViewController.h"

@interface DynamicOptionsTableViewController ()
-(BOOL) amParent: (int) index;
@end


@implementation DynamicOptionsTableViewController

@synthesize questions;
@synthesize node;

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [questions count];
}

/*-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   

}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamicDefault" forIndexPath:indexPath];
    NSDictionary *dict = [self.questions objectAtIndex:indexPath.row];
    
    if ([self amParent: indexPath.row]){
        cell.textLabel.text = [[dict allKeys] objectAtIndex:0];
       //  = [[questions allKeys] objectAtIndex:indexPath.row];
    }else{
       
        NSString *key         = [[dict allKeys] objectAtIndex:0];
        NSDictionary *control = [dict objectForKey:key];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", key, [control objectForKey:@"type"]];
        
    }
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self amParent: indexPath.row]){
        //[self.delegate didSelectOption:[[self.questions allKeys] objectAtIndex:indexPath.row] withPath:@[self.node]];
    }
}


-(BOOL) amParent: (int) index{
  
    NSDictionary *dict = [self.questions objectAtIndex:index];
    NSString *key = [[dict allKeys] objectAtIndex:0];
    id subobject = [dict objectForKey:key];
  
    
    if ([subobject isKindOfClass:[NSArray class]]){
        return TRUE;
    }
    return FALSE;
}

-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
     NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    return [self amParent:path.row];
}

#pragma mark - Delegates

-(void) didSelectOption:(NSString*) option withPath:(NSArray*)path{
    //pass it up the stack!
    if (self.node){
        path = [path arrayByAddingObjectsFromArray:@[self.node]];
    }
    [self.delegate didSelectOption:option withPath:path];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    NSDictionary *dict = [self.questions objectAtIndex:path.row];
    NSString *key = [[dict allKeys] objectAtIndex:0];
    NSArray *subquestions = [dict objectForKey:key];
    
    //NSString *key = [[self.questions allKeys] objectAtIndex:path.row];
    //NSDictionary *subquestions = [self.questions objectForKey:key];
    
    DynamicOptionsTableViewController* dvc = (DynamicOptionsTableViewController*) [segue destinationViewController];
    
    dvc.node = key;
    dvc.questions = subquestions;
    dvc.delegate = self;
}

@end
