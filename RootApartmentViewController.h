//
//  RootApartmentViewController.h
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageApartmentViewController.h"

@interface RootApartmentViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong,nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@end
