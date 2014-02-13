//
//  PageButtonViewController.h
//  SecondPageTest
//
//  Created by Tom Lodge on 13/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageButtonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
