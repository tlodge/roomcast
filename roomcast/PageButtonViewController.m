//
//  PageButtonViewController.m
//  SecondPageTest
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "PageButtonViewController.h"

@interface PageButtonViewController ()
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation PageButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ButtonCell"];
    self.titleLabel.text = self.titleText;
    //self.buttons = @[@[@"gym",@"mail",@"parking",@"key release", @"issue"],
      //    @[@"help", @"escort", @"suspicious"],
        //  @[@"lift", @"heating",@"gates", @"leak"]
        //];
    
    self.options = @{@"gym":@[@"please come to the gym", @"foreign item in pool"],
                     @"parking":@[@"please come to car park", @"my spot has been taken"],
                     @"key release":@[@"confirm release to above"],
                     @"issue":@[@"urgent", @"important"],
                     @"help":@[@"come to my apartment", @"come to my location!"],
                     @"escort":@[@"from tube", @"from bus stop"],
                     @"suspicious":@[@"still on site"],
                     @"lift":@[@"block1", @"block2", @"block3"],
                     @"heating":@[@"in apartment", @"in corridor"],
                     @"gates":@[@"access code failed", @"not locking"],
                     @"leak":@[@"urgent, high flow", @"important, medium flow", @"in apartment"]
                     };
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSLog(@" - in cv load - returning the number as %d", [self.buttons count]);
    if ([self.buttons count] <= 0){
        return 0;
    }
    return [self.buttons[_pageIndex] count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ButtonCell *cell;
    UIColor* fillcolor;
    
    NSLog(@"%d", (indexPath.row/2) % 2);
  
    if (((indexPath.row / 2) % 2)  == 0){
        if (indexPath.row % 2 == 0){
            cell = [cv dequeueReusableCellWithReuseIdentifier:@"ButtonCell" forIndexPath:indexPath];
             fillcolor = UIColorFromRGB(0x7c965e);
        }else{
            cell = [cv dequeueReusableCellWithReuseIdentifier:@"DarkButtonCell" forIndexPath:indexPath];
            fillcolor = UIColorFromRGB(0x5c7046);
        }
    }else{
        if (indexPath.row % 2 == 0){
            cell = [cv dequeueReusableCellWithReuseIdentifier:@"DarkButtonCell" forIndexPath:indexPath];
            fillcolor = UIColorFromRGB(0x5c7046);
        }else{
            cell = [cv dequeueReusableCellWithReuseIdentifier:@"ButtonCell" forIndexPath:indexPath];
            fillcolor = UIColorFromRGB(0x7c965e);

        }
    }
    
    [cell setFillColor:fillcolor];
    cell.buttonText.text = self.buttons[_pageIndex][indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RootButtonOptionsViewController* rbovc = (RootButtonOptionsViewController*) [segue destinationViewController];
    
    NSIndexPath *selected = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
    NSLog(@"have selected index %d", selected.row);
    rbovc.options = [self.options objectForKey:self.buttons[_pageIndex][selected.row]];
   
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    NSLog(@"selected!!! great!!");
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(120, 120);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //frame is 320 (10px in middle)
    //20--115--20--115--20
    UIEdgeInsets insets = {.left=26, .right=26, .bottom=0, .top=10};
    return insets;
}

-(void) reload{
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
}

@end
