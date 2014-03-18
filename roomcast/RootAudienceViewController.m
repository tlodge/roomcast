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

@synthesize TYPES;
@synthesize scope;
@synthesize development;
@synthesize developments;
@synthesize totals;
@synthesize currentScope;


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
    
    self.development  = [[DataManager sharedManager] development];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"developmentsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSLog(@"seen a developments update from network, so refetching from core data for development %@", self.development);
        self.developments = [[DataManager sharedManager] neighboursForDevelopment:self.development.objectId];
        
    }];
    
    self.TYPES = @[@"development", @"apartment", @"developments", @"region"];
    self.scope =  [NSMutableDictionary dictionary];
    self.totals = [NSMutableDictionary dictionary];
    
    for (NSString *type in TYPES){
        NSMutableDictionary *entities = [NSMutableDictionary dictionary];
        //set the default scope to whole development i.e. all blocks selected
        int total = 0;
        if ([type isEqualToString:@"development"]){
            for (Block* block in development.blocks){
                [entities setObject:block forKey:block.objectId];
                total += [block.residents intValue];
            }
            [self.totals setValue:[NSNumber numberWithInt:total] forKey:@"development"];
            
        }
        [self.scope setObject:entities forKey:type];
    }
    self.development  = self.development;
    self.developments = [[DataManager sharedManager] neighboursForDevelopment:self.development.objectId];

    
    
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
     
         NSLog(@"ok am in here!!");
         
         //UINavigationController *nc =  (UINavigationController *)[segue destinationViewController];
         
         //DestinationViewController* destination =(DestinationViewController*) [nc.viewControllers objectAtIndex:0];
         
         DestinationViewController* destination = (DestinationViewController*) [segue destinationViewController];
         
         destination.scopedelegate       = self;
         destination.scope               = self.scope;
         destination.totals              = self.totals;
         destination.scopeTypes          = self.TYPES;
         NSLog(@"destaination scope types = %@", self.TYPES);
         
         destination.developmentName     = self.development.name;
         NSLog(@"development name is %@", self.development.name);
         
         destination.developments        = self.developments;
         NSLog(@"developments are %@", destination.developments);
         
         NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
         
         NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
         
         destination.blocks = [[[self.development blocks] allObjects] sortedArrayUsingDescriptors:sortDescriptors];
     
     }
}

#pragma mark - Delegate methods

-(void) didSelectScope:(NSString*) scopeName withValues:(NSDictionary*) scopeValues withSummary:(NSString*)summary{
    
    NSLog(@"IN DID SELECT SCOPE %@", scopeName);
    
    self.currentScope = scopeName;
    
    [self.scope setObject:scopeValues forKey: scopeName];
    
    NSLog(@"%@", [self.scope objectForKey:scopeName]);
    
    self.whoToSummaryLabel.text = summary;
    //self.audienceCount.text = [NSString stringWithFormat:@"%d", [[self.totals objectForKey:scopeName] intValue]];
}


@end
