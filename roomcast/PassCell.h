//
//  PassCell.h
//  roomcast
//
//  Created by Tom Lodge on 31/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PassCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *passwordlabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;

@end
