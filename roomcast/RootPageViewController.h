//
//  RootPageViewController.h
//  roomcast
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageButtonViewController.h"

@interface RootPageViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong,nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@end
