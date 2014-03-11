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
@synthesize apartments;
@synthesize objectId;

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
    //_blocks = @[@"title one", @"title two", @"title three"];
    //_pageImages = @[@"page1", @"page2", @"page3"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageApartmentViewController *startingViewController = [self viewControllerAtIndex:0];
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
    
    if ((index == 0) || (index == NSNotFound)){
        return nil;
    }
    index--;
    return [self viewControllerAtIndex: index];
}

-(UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = ((PageApartmentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound){
        return nil;
    }
    index++;
    if (index == [self.blocks count]){
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

-(PageApartmentViewController*) viewControllerAtIndex:(NSUInteger) index
{
    if ( ([self.blocks count] == 0) || (index >= [self.blocks count])){
        return nil;
    }
    PageApartmentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageApartmentViewController"];
    Block* b = [self.blocks objectAtIndex:index];
    pageContentViewController.titleText = b.name;
    pageContentViewController.pageIndex = index;
    return pageContentViewController;
}

-(NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return [self.blocks count];
}

-(NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return 0;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
