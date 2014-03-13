//
//  PageApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "PageApartmentViewController.h"

@interface PageApartmentViewController ()
@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@end

@implementation PageApartmentViewController

@synthesize apartments;

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
    self.selectedIndexPaths = [NSMutableArray array];
    self.titleLabel.text = self.titleText;
	// Do any additional setup after loading the view.
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.apartments count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ApartmentSelectCell *cell;
     cell = [cv dequeueReusableCellWithReuseIdentifier:@"ApartmentSelectCell" forIndexPath:indexPath];
    
    Apartment *a = self.apartments[indexPath.row];
    cell.name.text = a.name;
    if ([self.selections containsObject:a]){
        cell.image.image = [UIImage imageNamed:@"apartment_scope_selected.png"];
    }
    else{
       cell.image.image = [UIImage imageNamed:@"apartment_scope.png"];
    }
   // cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apartment_scope_selected.png"]];
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Apartment* a  = [self.apartments objectAtIndex:indexPath.row];
    [self.delegate didSelectApartment:a];
    //this text needs to be passed in by root controller!
    self.selectedLabel.text = [[self.selections valueForKeyPath:@"name"] componentsJoinedByString:@","];
     
    [cv reloadData];
}


#pragma mark – UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 70);
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets insets = {.left=10, .right=10, .bottom=0, .top=10};
    return insets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
