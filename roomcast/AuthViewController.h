//
//  AuthViewController.h
//  roomcast
//
//  Created by Tom Lodge on 24/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RangeView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AuthViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *zoneMap;
@property (strong, nonatomic) RangeView *rangeView;
- (IBAction)back:(id)sender;

@end
