//
//  ApartmentViewController.h
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "BlockCell.h"
#import "ApartmentViewController.h"

@interface BlockViewController : UITableViewController <ApartmentAddDelegate>
@property (retain,nonatomic) NSArray *blocks;
@property (weak, nonatomic) Block* selectedBlock;
@property (retain, nonatomic) NSMutableDictionary *selections;
@property (retain, nonatomic) NSMutableDictionary *totals;
@property(nonatomic, assign) id <ApartmentAddDelegate> apartmentdelegate;
@end
