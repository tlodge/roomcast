//
//  DevelopmentViewController.h
//  roomcast
//
//  Created by Tom Lodge on 17/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "DevelopmentBlockCell.h"

@protocol DevelopmentAddDelegate;

@interface DevelopmentViewController : UITableViewController
@property(nonatomic,weak) NSArray* blocks;
@property(nonatomic,strong) NSMutableArray *selections;//can be weak now?
@property(nonatomic,assign) BOOL aggregateSelect;

- (IBAction)selectionChanged:(id)sender;
@property(nonatomic, assign) int totalSelected;
@property(nonatomic, strong) NSString* developmentName;

@property(assign, nonatomic) id <DevelopmentAddDelegate> developmentdelegate;

@end

@protocol DevelopmentAddDelegate <NSObject>
-(void) didSelectBlock:(Block*) block withValue: (BOOL) value;
-(void) didSelectAllBlocks: (BOOL) value;
@end