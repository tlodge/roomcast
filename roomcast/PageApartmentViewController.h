//
//  PageApartmentViewController.h
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApartmentSelectCell.h"
#import "Apartment.h"
#import "ApartmentAddProtocol.h"

@interface PageApartmentViewController :  UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property(nonatomic, strong) NSArray *apartments;
@property(nonatomic, weak) NSMutableArray *selections;
@property(nonatomic, assign) id <ApartmentAddDelegate> delegate;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@property NSString *blockId;
@property NSString *selectedLabelText;
@end
