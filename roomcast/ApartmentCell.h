//
//  ApartmentCell.h
//  roomcast
//
//  Created by Tom Lodge on 27/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *selectSwitch;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
