//
//  RootApartmentViewController.m
//  roomcast
//
//  Created by Tom Lodge on 06/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "RootApartmentViewController.h"

@interface RootApartmentViewController ()

@end

@implementation RootApartmentViewController

@synthesize selections;
@synthesize objectId;
@synthesize startIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *selectButton = [[UIBarButtonItem alloc] initWithTitle:@"SELECT ALL" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = selectButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.selectionsByBlock = [NSMutableDictionary dictionary];
    
    for (Block *b in self.blocks){
        [self.selectionsByBlock setObject:[NSMutableArray array] forKey:b.objectId];
    }
    
    for (Apartment *a in self.selections){
    
        NSMutableArray* blockselections = [self.selectionsByBlock objectForKey:a.block.objectId];
        [blockselections addObject:a];
    }
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
  
    self.pageViewController.dataSource = self;
    
    PageApartmentViewController *startingViewController = [self viewControllerAtIndex:self.startIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageViewController.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
	// Do any additional setup after loading the view.
}

#pragma mark - Page View Controller Data Source

-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = ((PageApartmentViewController*) viewController).pageIndex;
    if (index == NSNotFound){
        return nil;
    }
    
    index = (--index) % [self.blocks count];
    return [self viewControllerAtIndex: index];
}

-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageApartmentViewController*) viewController).pageIndex;
    if (index == NSNotFound){
        return nil;
    }
 
    index = (++index) % [self.blocks count];
    return [self viewControllerAtIndex:index];
}

-(PageApartmentViewController*) viewControllerAtIndex:(NSUInteger) index
{
    if ( ([self.blocks count] == 0) || (index >= [self.blocks count])){
        return nil;
    }
    PageApartmentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageApartmentViewController"];
    
    Block* b = [self.blocks objectAtIndex:index];
   
    NSArray* apartments = [[DataManager sharedManager] apartmentsForBlock:b.objectId];
    
    pageContentViewController.titleText         = b.name;
    pageContentViewController.pageIndex         = index;
    pageContentViewController.apartments        = apartments;
    pageContentViewController.blockId           = b.objectId;
    pageContentViewController.selections        = [self.selectionsByBlock objectForKey:b.objectId];
    
    pageContentViewController.delegate      = self;
    return pageContentViewController;
}

-(NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.blocks count];
}

-(NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return self.startIndex;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma apartmentAddDelegate protocol method

-(void) didSelectApartment:(Apartment*) apartment forBlockId:(NSString *)blockId{
    
    NSMutableArray* selected = [self.selectionsByBlock objectForKey:blockId];
    
    if ([selected containsObject:apartment]){
        [selected removeObject:apartment];
    }else{
        [selected addObject:apartment];
    }
    
    [self.delegate didSelectApartment:apartment forBlockId:blockId];
}
@end
