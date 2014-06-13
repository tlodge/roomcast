//
//  RootPageViewController.h
//  roomcast
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageButtonViewController.h"
#import "DataManager.h"
#import "DataRefreshProtocol.h"

@interface RootPageViewController : UIViewController <UIPageViewControllerDataSource, DataRefreshDelegate>

@property (strong,nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *pageTitles;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSMutableDictionary *groups;
@property (strong, nonatomic) NSMutableArray *pbvcs;
@end
