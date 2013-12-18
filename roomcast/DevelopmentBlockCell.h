//
//  DevelopmentBlockCell.h
//  roomcast
//
//  Created by Tom Lodge on 17/12/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DevelopmentBlockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *blockNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalSelectedLabel;
@property (weak, nonatomic) IBOutlet UISwitch *selectedSwitch;

@end
