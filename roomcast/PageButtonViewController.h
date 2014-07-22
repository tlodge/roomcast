//
//  PageButtonViewController.h
//  SecondPageTest
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonCell.h"
#import "ButtonSelectedViewController.h"
#import "ButtonPressProtocol.h"
#import "Button.h"
#import "RPCManager.h"
#import "DataRefreshProtocol.h"

@interface PageButtonViewController : UIViewController  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ButtonPressDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic, weak) NSArray *buttons;
@property(nonatomic, strong) NSDictionary *options;
@property(nonatomic, strong) UIRefreshControl *refreshControl;
@property(nonatomic, assign) id <DataRefreshDelegate> delegate;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

-(void) reload;
@end
