//
//  RootFeedbackController.h
//  roomcast
//
//  Created by Tom Lodge on 26/06/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedbackProtocol.h"
#import "FeedbackTableViewController.h"
#import "DataManager.h"

@interface RootFeedbackController : UIViewController <FeebackSelectedDelegate>
- (IBAction)sendPressed:(id)sender;
@property(nonatomic,assign) int rating;
@property(nonatomic,strong) NSString* notificationId;
@end
