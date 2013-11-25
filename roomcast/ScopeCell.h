//
//  ScopeCell.h
//  roomcast
//
//  Created by Tom Lodge on 25/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScopeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scopetitle;
@property (weak, nonatomic) IBOutlet UILabel *scopetotal;

@property (weak, nonatomic) IBOutlet UILabel *scopeinfo;
@end
