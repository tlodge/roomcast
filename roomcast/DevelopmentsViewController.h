//
//  DevelopmentsViewController.h
//  roomcast
//
//  Created by Tom Lodge on 08/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DevelopmentCell.h"
#import "Development.h"

@protocol DevelopmentsAddDelegate;

@interface DevelopmentsViewController : UITableViewController

@property(weak, nonatomic) NSMutableArray* developments;
@property(nonatomic, assign) id <DevelopmentsAddDelegate> developmentsdelegate;
@property(nonatomic,strong) NSMutableArray *selections; //shoudl be weak!!??

@end

@protocol DevelopmentsAddDelegate <NSObject>

-(void) didSelectDevelopment:(Development*) development withValue:(BOOL)value;

@end