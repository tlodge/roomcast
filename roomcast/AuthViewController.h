//
//  AuthViewController.h
//  roomcast
//
//  Created by Tom Lodge on 24/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rangeView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AuthViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *zoneMap;
//@property (retain, nonatomic) UIView *circleView;
@property (retain, nonatomic) rangeView *rangeView;
@end
