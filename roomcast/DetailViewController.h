//
//  DetailViewController.h
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
-(void) setText: (NSString *) newText;

@end
