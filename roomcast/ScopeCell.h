//
//  ScopeCell.h
//  roomcast
//
//  Created by Tom Lodge on 25/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScopeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *scopeImage;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UILabel *info;
@end
