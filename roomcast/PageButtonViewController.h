//
//  PageButtonViewController.h
//  SecondPageTest
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonCell.h"
#import "RootButtonOptionsViewController.h"

@interface PageButtonViewController : UIViewController  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic, strong) NSArray *buttons;
@property(nonatomic, strong) NSDictionary *options;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
