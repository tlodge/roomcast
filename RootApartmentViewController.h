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
#import "DataManager.h"
#import "ApartmentAddProtocol.h"

@interface RootApartmentViewController : UIViewController <UIPageViewControllerDataSource, ApartmentAddDelegate>

@property (strong,nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray* blocks;
@property (weak, nonatomic) NSMutableArray* selections;
@property (retain, nonatomic) NSString* objectId;
@property(nonatomic, assign) id <ApartmentAddDelegate> delegate;
@end


