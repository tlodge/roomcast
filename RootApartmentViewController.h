//
//  RootApartmentViewController.h
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageApartmentViewController.h"
#import "Apartment.h"
#import "Block.h"
@protocol ApartmentAddDelegate;

@interface RootApartmentViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong,nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray* blocks;
@property (retain, nonatomic) NSArray* apartments;

@property (retain, nonatomic) NSDictionary* selections;
@property (retain, nonatomic) NSString* objectId;
@property(nonatomic, assign) id <ApartmentAddDelegate> delegate;
@end

@protocol ApartmentAddDelegate <NSObject>

-(void) didSelectApartment:(Apartment*) apartment withValue:(BOOL)value;

@end
