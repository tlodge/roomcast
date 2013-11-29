//
//  ApartmentViewController.h
//  roomcast
//
//  Created by Tom Lodge on 26/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"
#import "DataManager.h"
#import "Block.h"
#import "Apartment.h"

@interface ApartmentViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectToggle;
@property (retain, nonatomic) UIButton *switchOn;
@property (retain, nonatomic) UIButton *switchOff;
@property (weak,nonatomic) NSArray* apartments;
@property (retain, nonatomic) NSMutableArray* selections;
@property (weak, nonatomic) Block *block;
@end
