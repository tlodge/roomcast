//
//  DestinationViewController.h
//  roomcast
//
//  Created by Tom Lodge on 21/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScopeCell.h"
#import "BlockViewController.h"
#import "ApartmentViewController.h"

@protocol MessageScopeDelegate;

@interface DestinationViewController : UITableViewController <ApartmentAddDelegate>

@property(retain,nonatomic) NSMutableDictionary* apartmentScope;
@property(retain,nonatomic) NSIndexPath *lastIndex;
@property(assign, nonatomic) id <MessageScopeDelegate> scopedelegate;
@end

@protocol MessageScopeDelegate <NSObject>
-(void) didSelectScope:(NSDictionary*) scope;
@end