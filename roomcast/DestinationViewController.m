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
@property(nonatomic,retain) NSArray* scopeimages;
@property(nonatomic,retain) NSArray* scopetext;
@end

//should be dynamic, so could potentially add new scopes!
//scope


//[scope] :: NSMutableDict [type, entity]
//type    :: "apartment", "development", "developments", "region"
//entity  :: NSMutableDict [key, object]
//key     :: objectId
//object  :: Apartment || Block || Development


//[filter]:: NSMutableDict [type, entity]
//type    :: "apartment", "development", "developments", "region"
//entity  :: NSMutableDict [filtertype, object]
//filtertype:: floor, tenancy, management company


@implementation DestinationViewController

@synthesize lastIndex;
@synthesize scopedelegate;
@synthesize currentScope;
@synthesize scopeTypes;
@synthesize scope;
@synthesize filter;
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
    self.title = @"choose scope";
    self.filter = [NSMutableDictionary dictionary];
    
    self.scopeimages = @[@"within_scope.png", @"apartment_scope.png", @"development_scope.png",@"region_scope.png"];
    
    self.scopetext = @[@"within development", @"specific apartments", @"across developments", @"across region"];
    
    self.currentScope = [self.scopeTypes objectAtIndex:0];
    lastIndex = [NSIndexPath indexPathForItem:1 inSection:1];
    self.clearsSelectionOnViewWillAppear = NO;
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
    
    if (lastIndex){
        ScopeCell* cell = (ScopeCell*)[tableView cellForRowAtIndexPath:lastIndex];
        [self setDeselected:cell];
    }
    
    ScopeCell* cell = (ScopeCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self setSelected:cell];
    
    
    lastIndex = indexPath;
    
    if (![self.currentScope isEqualToString:[self.scopeTypes objectAtIndex:indexPath.row]]){
        self.currentScope = [self.scopeTypes objectAtIndex:indexPath.row];
        [self.scopedelegate didSelectScope:self.currentScope withValues:[scope objectForKey:self.currentScope]];
    }
    
    [self triggerSegue:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScopeCell* cell =  (ScopeCell*)[tableView dequeueReusableCellWithIdentifier:@"ScopeCell" forIndexPath:indexPath];
    
    if (lastIndex.row == indexPath.row){
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
        [self setSelected:cell];
        lastIndex = indexPath;
    }
    
    cell.title.text = self.scopetext[indexPath.row];
    cell.info.text = [self _text_for_scope:[self.scopeTypes objectAtIndex:indexPath.row]];
    cell.scopeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.scopeimages[indexPath.row]]];
    cell.selectedView.alpha = 0;
    
    return cell;
}

-(NSString*) _text_for_scope:(NSString *) scopename{
    NSArray *entities = [[self.scope objectForKey:scopename] allValues];
    return [[entities valueForKey:@"name"]componentsJoinedByString:@", "];
}

-(NSString *) _total_for_scope:(NSString *) scopename{
    if ([self.totals objectForKey:scopename] != nil)
        return [NSString stringWithFormat:@"%@",[self.totals objectForKey:scopename]];
    return @"0";
}

-(void) triggerSegue:(NSIndexPath *)currentIndex{
    
    if (lastIndex != nil){
        ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:lastIndex];
        [self setDeselected:cell];
    }
    
    ScopeCell* cell = (ScopeCell*)[self.tableView cellForRowAtIndexPath:currentIndex];
    [self setSelected:cell];
   
    lastIndex = currentIndex;
    int tag = currentIndex.row;
    
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
       // bvc.apartmentdelegate = self;
        bvc.selections = [self.scope objectForKey:@"apartment"];
        bvc.blocks = self.blocks;
       // bvc.apartmenttotals = self.apartmenttotals;
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
    if ([self isMovingFromParentViewController]){
        [self.scopedelegate didSelectScope:self.currentScope withValues:[scope objectForKey:self.currentScope]];
       
    }
}

#pragma delegate methods

-(void) didSelectDevelopment:(Development*)development withValue:(BOOL)value{
    
    int total = 0;
    
    NSNumber* residents = [self.totals objectForKey:@"developments"];
    
    if (!residents)
        residents = [NSNumber numberWithInt:0];

    if (value){
        [[self.scope objectForKey:@"developments" ] setObject:development forKey:development.objectId];
         total = [residents intValue] + [development.residents intValue];
        [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"developments"];
    }else{
        [[self.scope objectForKey:@"developments" ] removeObjectForKey:development.objectId];
        total = [residents intValue] - [development.residents intValue];
        [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"developments"];
    }
}

-(void) didSelectApartment:(Apartment*)apartment withValue:(BOOL)value{
    if (value){
       [[self.scope objectForKey:@"apartment" ] setObject:apartment forKey:apartment.objectId];
    }else{
        [[self.scope objectForKey:@"apartment" ] removeObjectForKey:apartment.objectId];
    }
    
    [self.totals setObject:[NSNumber numberWithInt:[[[self.scope objectForKey:@"apartment"] allValues] count]] forKey:@"apartment"];
}

-(void) didSelectBlock:(Block*) block withValue: (BOOL) value{
    
    int total = 0;
    NSNumber* residents = [self.totals objectForKey:@"development"];
    
    if (!residents)
        residents = [NSNumber numberWithInt:0];
    
    if (value){
        [[self.scope objectForKey:@"development" ] setObject:block forKey:block.objectId];
        total = [residents intValue] + [block.residents intValue];
        [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"development"];
        
    }else{
        [[self.scope objectForKey:@"development" ] removeObjectForKey:block.objectId];
        total = [residents intValue] - [block.residents intValue];
        [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"development"];
    }
   
}

-(void) didSelectAllBlocks: (BOOL)selected{
   
    int total = 0;
    
    if (selected){
        for (int i=0; i < [self.blocks count]; i++){
            Block *b = [self.blocks objectAtIndex:i];
            [[self.scope objectForKey:@"development" ] setObject:b forKey:b.objectId];
            total += [b.residents intValue];
        }
    }else{
        [[self.scope objectForKey:@"development"] removeAllObjects];
    }
    
    [self.totals setObject:[NSNumber numberWithInt:total] forKey:@"development"];
    
}

@end
