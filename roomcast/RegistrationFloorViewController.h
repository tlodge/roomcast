//
//  RegistrationFloorViewController.h
//  roomcast
//
//  Created by Tom Lodge on 10/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FloorSelectDelegate;

@interface RegistrationFloorViewController : UITableViewController
@property(weak,nonatomic) NSArray* floors;
@property(nonatomic, assign) id <FloorSelectDelegate> delegate;
@end

@protocol FloorSelectDelegate <NSObject>
    -(void) didSelectFloor:(NSString*) floor;
@end