//
//  DestinationViewController.m
//  roomcast
//
//  Created by Tom Lodge on 21/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()
-(NSString *) _text_for_scope:(NSString *) scopename;
-(NSString *) _total_for_scope:(NSString *) scopename;
-(void) setSelected:(ScopeCell*) cell;
-(void) setDeselected:(ScopeCell*) cell;
-(void) triggerSegue:(NSIndexPath *)currentIndex;
@property(nonatomic,strong) NSArray* scopeimages;
@property(nonatomic,strong) NSArray* scopetext;
@property(nonatomic,strong) NSString* summarytext;
@end

//should be dynamic, so could potentially add new scopes!
//scope


//[scope] :: NSMutableDict [type, entity]
//type    :: "apartment", "development", "developments", "region"
//entity  :: NSMutableArray [object]
//object  :: Apartment || Block || Development


//[filter]:: NSMutableDict [type, entity]
//type    :: "apartment", "development", "developments", "region"
//entity  :: NSMutableDict [filtertype, object]
//filtertype:: floor, tenancy, management company


@implementation DestinationViewController

@synthesize segueIndex;
@synthesize scopedelegate;
@synthesize currentScope;
@synthesize scopeTypes;
@synthesize scope;
@synthesize blocks;
@synthesize developments;
@synthesize developmentName;
@synthesize totals;
//@synthesize apartmenttotals;

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

    self.scopeimages = @[@"within_scope.png", @"apartment_scope.png", @"development_scope.png",@"region_scope.png"];
    
    self.scopetext = @[@"within development", @"specific apartments", @"across developments", @"across region"];
    
    self.currentScope = [self.scopeTypes objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return [self.scopeTypes count];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![self.currentScope isEqualToString:[self.scopeTypes objectAtIndex:indexPath.row]]){
        self.currentScope = [self.scopeTypes objectAtIndex:indexPath.row];
        
        /*[self.scopedelegate didSelectScope:self.currentScope withValues:[scope objectForKey:self.currentScope]];*/
    }
    
    [self triggerSegue:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *path;
    
    if (segueIndex){
        path = segueIndex;
    }else{
        path = [self.tableView indexPathForSelectedRow];
    }
    
    ScopeCell* cell =  (ScopeCell*)[tableView dequeueReusableCellWithIdentifier:@"ScopeCell" forIndexPath:indexPath];
    
   
    if (indexPath.row == path.row){
        [self setSelected:cell];
    }else{
        [self setDeselected:cell];
    }
    
    cell.title.text = self.scopetext[indexPath.row];
    cell.info.text = [self _text_for_scope:[self.scopeTypes objectAtIndex:indexPath.row]];
    cell.scopeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.scopeimages[indexPath.row]]];
    cell.selectedView.alpha = 0;
    
    return cell;
}

-(NSString*) _text_for_scope:(NSString *) scopename{
    NSMutableArray *entities = [self.scope objectForKey:scopename];
    return [[entities valueForKey:@"name"]componentsJoinedByString:@", "];
}

-(NSString *) _total_for_scope:(NSString *) scopename{
    if ([self.totals objectForKey:scopename] != nil)
        return [NSString stringWithFormat:@"%@",[self.totals objectForKey:scopename]];
    return @"0";
}


-(void) triggerSegue:(NSIndexPath *)currentIndex{
    
    segueIndex = [self.tableView indexPathForSelectedRow];
    
    //have to explicitly select/deselect cells as didDeselectRowAtIndex path not always called!
    
    
    for (int i =0; i < [self.scopeTypes count]; i++){
        if (i != currentIndex.row){
            NSIndexPath *p = [NSIndexPath indexPathForRow:i inSection:0];
            ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:p];
            [self setDeselected:cell];
        }
    }

    
    ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:currentIndex];
    [self setSelected:cell];
  
    int tag = (int) currentIndex.row;
    
    NSString *segue = @"withinDevelopmentSegue";
    
    if (tag == 1){
       segue = @"apartmentSegue";
    }
    else if (tag == 2){
       segue = @"acrossDevelopmentsSegue";
    }else if (tag == 3){
       segue = @"withinRegionSegue";
    }
    
    [self performSegueWithIdentifier:segue sender:self];
}

-(void) setSelected:(ScopeCell*) cell{
    cell.contentView.alpha = 1.0;
    cell.info.alpha = 1.0;
}

-(void) setDeselected:(ScopeCell*) cell{
    cell.contentView.alpha = 0.5;
    cell.info.alpha = 0.0;
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.0;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if ([[segue identifier] isEqualToString:@"apartmentSegue"]){
        BlockViewController* bvc = (BlockViewController *) [segue destinationViewController];
        bvc.apartmentdelegate = self;
        bvc.selections = [self.scope objectForKey:@"apartment"];
        bvc.blocks = self.blocks;
    }
    else if ([[segue identifier] isEqualToString:@"withinDevelopmentSegue"]){
        DevelopmentViewController* dvc = (DevelopmentViewController *) [segue destinationViewController];
        dvc.developmentdelegate = self;
        dvc.blocks = self.blocks;
        dvc.developmentName = self.developmentName;
        dvc.selections = [self.scope objectForKey:@"development"];
    }else if ([[segue identifier] isEqualToString:@"acrossDevelopmentsSegue"]){
        
        DevelopmentsViewController* dsvc = (DevelopmentsViewController *) [segue destinationViewController];
        dsvc.developments = self.developments;
        dsvc.selections = [self.scope objectForKey:@"developments"];
        dsvc.developmentsdelegate = self;
    }
}



-(void) viewWillDisappear:(BOOL)animated{
    
    NSMutableArray* myscope = [self.scope objectForKey:self.currentScope];
    self.summarytext = [[myscope valueForKeyPath:@"name"] componentsJoinedByString:@","];
    
    if ([self isMovingFromParentViewController]){
        //the following passes up a NULL withValues....
        [self.scopedelegate didSelectScope:self.currentScope withValues:[scope objectForKey:self.currentScope] withSummary:self.summarytext];
       
    }
}

#pragma delegate methods

-(void) didSelectDevelopment:(Development*)development withValue:(BOOL)value{
    
    int total = 0;
    NSNumber* residents = [self.totals objectForKey:@"developments"];
    NSMutableArray* localscope = [self.scope objectForKey:@"developments"];
    
    if (!residents)
        residents = [NSNumber numberWithInt:0];

    if (value){
        [localscope addObject:development];
        total = [residents intValue] + [development.residents intValue];
        [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"developments"];
    }else{
        [localscope removeObject:development];
        total = [residents intValue] - [development.residents intValue];
        [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"developments"];
    }
    [self.tableView reloadData];
}


-(void) didSelectApartment:(Apartment*)apartment forBlockId:(NSString *)blockId{
    
    
    NSMutableArray* apartments = [self.scope objectForKey:@"apartment"];
    
    
    if ([apartments containsObject:apartment]){
        [apartments removeObject:apartment];
    }else{
        [apartments addObject:apartment];
    }
    
    [self.totals setObject:[NSNumber numberWithInt:(int)[apartments count]] forKey:@"apartment"];
    
    [self.tableView reloadData];
}


-(void) didSelectBlock:(Block*) block withValue: (BOOL) value{
    
    int total = 0;
    NSNumber* residents = [self.totals objectForKey:@"development"];
    
    
    NSMutableArray* localscope = [self.scope objectForKey:@"development"];
    
    if (!residents)
        residents = [NSNumber numberWithInt:0];
    
    if (value){
        if (![localscope containsObject:block]){
            [localscope addObject:block];
            total = [residents intValue] + [block.residents intValue];
            [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"development"];
        }
    }else{
        if ([localscope containsObject:block]){
            [localscope removeObject:block];
            total = [residents intValue] - [block.residents intValue];
            [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"development"];
        }
    }

    [self.tableView reloadData];

}

-(void) didSelectAllBlocks: (BOOL)selected{
   
    int total = 0;
    NSMutableArray* localscope = [self.scope objectForKey:@"development"];
    
    if (selected){
        for (int i=0; i < [self.blocks count]; i++){
            Block *b = [self.blocks objectAtIndex:i];
            if (![localscope containsObject:b]){
                [localscope addObject:b];
                total += [b.residents intValue];
            }
        }
    }else{
        [localscope removeAllObjects];
    }
    
    [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"development"];
    [self.tableView reloadData];
    
}

@end
