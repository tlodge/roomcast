//
//  RegistrationBlockViewController.h
//  roomcast
//
//  Created by Tom Lodge on 10/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Block.h"

@protocol BlockSelectDelegate;
@interface RegistrationBlockViewController : UITableViewController
@property(weak,nonatomic) NSArray* blocks;

@property(nonatomic, assign) id <BlockSelectDelegate> delegate;
@end

@protocol BlockSelectDelegate <NSObject>
// recipe == nil on cancel
-(void) didSelectBlock:(Block*) block;
@end