//
//  PageApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "PageApartmentViewController.h"

@interface PageApartmentViewController ()

@end

@implementation PageApartmentViewController

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
    self.titleLabel.text = self.titleText;
    self.buttons = @[@[@"button1",@"button2",@"button3",@"button4",@"button5",@"button6", @"button7", @"button8"],
                     @[@"abcdefg", @"hijklmnop",@"qrstuvw"],
                     @[@"cdefg", @"dksldlks", @"dlksdlk", @"sdkjsdj"]
                     ];

	// Do any additional setup after loading the view.
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.buttons[_pageIndex] count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ApartmentSelectCell *cell;
     cell = [cv dequeueReusableCellWithReuseIdentifier:@"ApartmentSelectCell" forIndexPath:indexPath];
   
    return cell;
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
    return CGSizeMake(50, 70);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //frame is 320 (10px in middle)
    //20--115--20--115--20
    UIEdgeInsets insets = {.left=10, .right=10, .bottom=0, .top=10};
    return insets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
