//
//  AuthViewController.h
//  roomcast
//
//  Created by Tom Lodge on 24/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RangeView.h"
#import "Development.h"
#import "RPCManager.h"

@interface AuthViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *zoneMap;
@property (weak, nonatomic) IBOutlet UILabel *helpLabel;
@property (weak, nonatomic) IBOutlet RangeView *rangeView;
@property (strong, nonatomic) Development *development;

- (IBAction)back:(id)sender;


@end
