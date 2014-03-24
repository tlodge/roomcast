//
//  SendRootViewController.h
//  roomcast
//
//  Created by Tom Lodge on 21/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageScopeProtocol.h"
#import "MessageFilterProtocol.h"
#import "RootAudienceViewController.h"
#import "Development.h"

@interface SendRootViewController : UIViewController <UITextViewDelegate, MessageScopeDelegate, MessageFilterDelegate>

@property (weak, nonatomic) IBOutlet UITextView *sendText;
@property (weak, nonatomic) IBOutlet UILabel *audienceCount;
@property (weak, nonatomic) IBOutlet UILabel *whoToLabel;

@property (strong,nonatomic) NSMutableDictionary* totals;
@property (strong,nonatomic) Development* development;
@property (strong,nonatomic) NSArray* developments;

@property (strong,nonatomic) NSMutableDictionary *scope;
@property (strong, nonatomic) NSArray* scopeTypes;
@property (strong,nonatomic) NSString *currentScope;

@property (strong, nonatomic) NSArray *filters;
@property (strong,nonatomic) NSMutableArray* selectedFilters;

- (IBAction)sendAnonPressed:(id)sender;
- (IBAction)sendPressed:(id)sender;
@end
