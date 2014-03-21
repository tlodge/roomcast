//
//  ApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()
-(NSString *) _selectionString: (NSString *) objectId;
-(int) _totalForBlock:(NSString *) objectId;
@property int selectedIndex;
@end

@implementation BlockViewController

@synthesize blocks;
@synthesize selectedBlock;
@synthesize selections;
@synthesize selectedIndex;

//@synthesize apartmentdelegate;

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
    self.selectedIndex = 0;
    self.clearsSelectionOnViewWillAppear = NO;
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
    return [self.blocks count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BlockCell";
    BlockCell *cell =  (BlockCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Block* b = [self.blocks objectAtIndex:indexPath.row];
    
    NSLog(@"setting totals for %@", b.objectId);
    
    cell.chosen.text = [NSString stringWithFormat:@"%@", [self _selectionString:b.objectId]];
    
   /* cell.moreButton.tag = indexPath.row;
    [cell.moreButton addTarget:self action:@selector(triggerSegue:) forControlEvents:UIControlEventTouchUpInside];*/
    cell.name.text = b.name;
    
    return cell;
}

/*-(void)  triggerSegue:(id)sender{

    UIButton *clicked = (UIButton *) sender;
    self.selectedBlock = [self.blocks objectAtIndex:clicked.tag];
    NSLog(@"clicked tag is %d", clicked.tag);
    self.selectedIndex = clicked.tag;
    [self performSegueWithIdentifier:@"selectApartments" sender:self];
}*/

/*-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
}*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    self.selectedBlock = [self.blocks objectAtIndex:path.row];
    self.selectedIndex = path.row;
    RootApartmentViewController* avc = (RootApartmentViewController*) [segue destinationViewController];
 
    avc.delegate   = self;
    avc.blocks     = self.blocks;
    avc.objectId   = selectedBlock.objectId;
    avc.selections = self.selections;
    avc.startIndex = self.selectedIndex;
}

#pragma apartment selected delegate
-(void) didSelectApartment:(Apartment*)apartment forBlockId:(NSString *)blockId{
   
    /*NSMutableArray *apartments = [self.selections objectForKey:blockId];
    
    if (apartments == nil){
        apartments = [NSMutableArray array];
    }
    
    if ([apartments containsObject:apartment]){
        [apartments removeObject:apartment];
    }else{
        [apartments addObject:apartment];
    }
    
    [self.selections setObject:apartments forKey:blockId];*/

    [self.apartmentdelegate didSelectApartment:apartment forBlockId:blockId];
    NSLog(@"BVC selected %d apartments", [self.selections count]);
    [self.tableView reloadData];

}

-(NSString *) _selectionString: (NSString *) blockId{
    if (self.selections && [self.selections count] > 0){
        
        NSMutableArray *selected = [NSMutableArray array];
        
        for (Apartment* a in self.selections){
            if (a.block.objectId == blockId){
                [selected addObject:a.name];
            }
        }
        if ([selected count] > 0)
            return [selected componentsJoinedByString:@","];
    }
    return @"none selected";
}

-(int) _totalForBlock:(NSString *) objectId{
    return [self.selections count];
}

@end
