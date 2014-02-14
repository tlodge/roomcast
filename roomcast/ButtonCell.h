//
//  ButtonCell.h
//  roomcast
//
//  Created by Tom Lodge on 14/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *buttonText;
@property(nonatomic,strong) UIColor *fillColor;
@end
