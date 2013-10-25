//
//  AuthViewController.m
//  roomcast
//
//  Created by Tom Lodge on 24/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "AuthViewController.h"

//define meters per mile
#define MPM 1609.344

@interface AuthViewController ()

@end


@implementation AuthViewController

CGMutablePathRef mpr;
NSMutableData *receivedData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*self.circleView = [[UIView alloc] initWithFrame:CGRectMake(10,10,100,100)];
    self.circleView.layer.cornerRadius = 50;
    self.circleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_circleView];*/
    
    self.rangeView = [[rangeView alloc] initWithFrame:CGRectMake(10,10,100,100)];
    [self.view addSubview:_rangeView];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:5000/data"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest: theRequest delegate:self];
    
    if (theConnection){
        receivedData = [NSMutableData data];
    }
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response{
    [receivedData setLength:0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data{
    [receivedData appendData: data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection{
    NSLog(@"succeeded receievd %d bytes of data", [receivedData length]);
    NSError *error = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&error];
    
    NSLog(@"JSON DATA IS %@", jsonArray);
    
    mpr = CGPathCreateMutable();
    NSInteger idx = 0;
    
    CLLocationCoordinate2D center;
   
  
    CLLocationCoordinate2D* coords = malloc(sizeof(CLLocationCoordinate2D) *[jsonArray count]);

    //construct the polygon
    for (NSArray *myarray in jsonArray) {
        CGFloat lat = [[myarray objectAtIndex:0] floatValue];
        CGFloat lng = [[myarray objectAtIndex:1] floatValue];
        MKMapPoint mp = {lat, lng};
        coords[idx] = CLLocationCoordinate2DMake(lat,lng);
         
        if (idx == 0){
            CGPathMoveToPoint(mpr, NULL, mp.x, mp.y);
            center.latitude = mp.x;
            center.longitude = mp.y;
        }
        else
            CGPathAddLineToPoint(mpr, NULL, mp.x, mp.y);
        
        idx++;
    
        NSLog(@"%f %f", mp.x,mp.y);
    }
   
    [self.zoneMap setDelegate:self];
    
    [self.zoneMap setRegion:MKCoordinateRegionMakeWithDistance(center, 0.05 * MPM,0.05*MPM) animated: YES];
    
   
    
    [self.zoneMap addOverlay:[MKPolygon polygonWithCoordinates:coords count:[jsonArray count]]];
    free(coords);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
   if ([overlay isKindOfClass:MKPolygon.class]) {
        MKPolygonRenderer *renderer = [[MKPolygonRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = [UIColor magentaColor];
        renderer.lineWidth = 1;
        renderer.fillColor = [UIColor magentaColor];
        return renderer;
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"MAP SEEN LOCATION CHANGE!");
}

@end
