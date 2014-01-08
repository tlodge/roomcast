//
//  DevelopmentCell.h
//  roomcast
//
//  Created by Tom Lodge on 08/01/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DevelopmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;
@property (weak, nonatomic) IBOutlet UILabel *total;

@end
