//
//  RootPageViewController.m
//  roomcast
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "RootPageViewController.h"

@interface RootPageViewController ()
@end

@implementation RootPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pbvcs = [NSMutableArray array];
    self.groups = [NSMutableDictionary dictionary];
    self.buttons = [NSMutableArray array];
    
    [[DataManager sharedManager] buttonsForUser];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"buttonsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSDictionary* userInfo = note.userInfo;
        NSDictionary* ng  = [userInfo objectForKey:@"buttongroups"];
        [_pageTitles removeAllObjects];
        
        
        [self.buttons removeAllObjects];
        
        for (NSString* key in [ng allKeys]){
            [self.groups setObject:[ng objectForKey:key] forKey:key];
            [_pageTitles addObject:key];
            [self.buttons addObject:[ng objectForKey:key]];
            //NSArray *pbuttons = [ng objectForKey:key];
            //NSArray *buttonnames = [pbuttons valueForKey:@"name"];
            //[self.buttons addObject:buttonnames];
        }
         for (int i = 0; i <[self.pageTitles count]; i++){
            PageButtonViewController *pbvc = [self viewControllerAtIndex: i];
            pbvc.buttons = self.buttons;
            [pbvc reload];
        }
        
        [self.pageViewController setViewControllers:[NSArray arrayWithObject:[self viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }];
    _pageTitles = [NSMutableArray array];
    [_pageTitles addObject:@""];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    self.pageViewController.dataSource = self;
    
    PageButtonViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageViewController.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Page View Controller Data Source

-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageButtonViewController*) viewController).pageIndex;
  
    if ((index == 0) || (index == NSNotFound)){
        return nil;
    }
    index--;
    return [self viewControllerAtIndex: index];
}

-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageButtonViewController*) viewController).pageIndex;

    if (index == NSNotFound){
        return nil;
    }
    index++;
    if (index == [self.pageTitles count]){
        return nil;
    }
    [self viewControllerAtIndex:index];
    return [self viewControllerAtIndex:index];
}

-(PageButtonViewController*) viewControllerAtIndex:(NSUInteger) index
{
    
    if ( ([self.pageTitles count] == 0) || (index >= [self.pageTitles count])){
        return nil;
    }
    
    if ([_pbvcs count] <= index){

        PageButtonViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageButtonViewController"];
        pageContentViewController.titleText = self.pageTitles[index];
        pageContentViewController.buttons = self.buttons;
        pageContentViewController.pageIndex = index;
        [_pbvcs addObject:pageContentViewController];
        return pageContentViewController;
    }else{
        PageButtonViewController *pageContentViewController = [_pbvcs objectAtIndex: index];
        pageContentViewController.titleLabel.text = self.pageTitles[index];
        return pageContentViewController;
    }
    
}

-(NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.pageTitles count];
}

-(NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}

@end
