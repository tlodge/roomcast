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

@protocol ApartmentAddDelegate;

@interface ApartmentViewController : UITableViewController
@property (weak,   nonatomic) IBOutlet UIBarButtonItem *selectToggle;
@property (retain, nonatomic) UIButton *switchOn;
@property (retain, nonatomic) UIButton *switchOff;
@property (retain, nonatomic) NSArray* apartments;
@property (retain, nonatomic) NSDictionary* selections;
@property (retain, nonatomic) NSString* blockId;

@property(nonatomic, assign) id <ApartmentAddDelegate> delegate;
@end

@protocol ApartmentAddDelegate <NSObject>
// recipe == nil on cancel
-(void) didSelectApartment:(Apartment*) apartment withValue:(BOOL)value;

@end
