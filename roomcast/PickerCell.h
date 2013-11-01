//
//  PickerCell.h
//  roomcast
//
//  Created by Tom Lodge on 31/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@end
