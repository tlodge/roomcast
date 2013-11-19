//
//  AuthViewController.m
//  roomcast
//
//  Created by Tom Lodge on 24/10/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "AuthViewController.h"
#import "RegistrationContainerViewController.h"
//define meters per mile
#define MPM 1609.344

@interface AuthViewController ()
-(float) calculatedistance: (float) lat1 lat2:(float) lat2 lng1:(float)lng1 lng2:(float) lng2;
-(int) calculatebearing: (float) lat1 lat2:(float) lat2 lng1:(float)lng1 lng2:(float) lng2;
-(float) calculatecrosstrack: (float) lat1 lat2:(float) lat2 lng1: (float) lng1 lng2:(float) lng2 lat3: (float)lat3 lng3: (float) lng3;
-(float) radians: (float) d;
-(int) degrees: (float) r;

@end


@implementation AuthViewController

@synthesize development;

CGMutablePathRef mpr;
NSMutableData *receivedData;
CLLocationManager *locationManager;
MKPolygon *authZone;


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
    NSLog(@"development is %@", [self.development objectForKey:@"name"]);
    
    self.rangeView = [[RangeView alloc] initWithFrame:CGRectMake(250,380,60,60)];
    [self.view addSubview:_rangeView];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://roomcast.herokuapp.com/data"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest: theRequest delegate:self];
    
    if (theConnection){
        receivedData = [NSMutableData data];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}


-(void) updateDistance:(float) d{
    
}

-(void) changeColor: (float) maxVal min:(float) minVal actual:(float) actual {
    
    int r = 255, g = 0, b = 0;
    
    if (actual < maxVal){
        
        float midVal = (maxVal - minVal)/2;
        
        if (actual >= midVal){
            r = 255;
            g = round(255 * ((maxVal - actual) / (maxVal - midVal)));
        }
        else{
            g = 255;
            r = round(255 * ((actual - minVal) / (midVal - minVal)));
        }
    }
    [self.rangeView setCircleColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]];
    [self.rangeView  setNeedsDisplay];
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
    
    }
   
    [self.zoneMap setDelegate:self];
    
    [self.zoneMap setRegion:MKCoordinateRegionMakeWithDistance(center, 0.05 * MPM,0.05*MPM) animated: YES];
    
   
    authZone = [MKPolygon polygonWithCoordinates:coords count:[jsonArray count]];
    
    [self.zoneMap addOverlay:authZone];
    
    free(coords);
}

#pragma location delegate methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"did fail with error!: %@", error);
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  
    if (mpr != nil){
        CLLocation *currentLocation = [locations lastObject];
        
        CGPoint mapPointAsCGP = CGPointMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        
        
        
        if (CGPathContainsPoint(mpr, NULL,mapPointAsCGP, FALSE)){
            [locationManager stopUpdatingLocation];
            [self performSegueWithIdentifier: @"register" sender: self];
        }else{
            
            CLLocationCoordinate2D firstcoord;
            CLLocationCoordinate2D lastcoord;
            float min = INFINITY;
            float dst = 0.0;
            
            for (int i = 0; i < authZone.pointCount; i++){
                MKMapPoint mp = authZone.points[i];
                CLLocationCoordinate2D loc = MKCoordinateForMapPoint(mp);
                
                if (i == 0){
                    firstcoord = loc;
                }else{
                    dst = [self calculatecrosstrack: lastcoord.latitude lat2:loc.latitude lng1: lastcoord.longitude lng2:loc.longitude lat3: currentLocation.coordinate.latitude lng3: currentLocation.coordinate.longitude];
            
                    min = fmin(min, dst);
                }
                lastcoord = loc;
            }
            
            dst = [self calculatecrosstrack: lastcoord.latitude lat2:firstcoord.latitude lng1: lastcoord.longitude lng2:firstcoord.longitude lat3: currentLocation.coordinate.latitude lng3: currentLocation.coordinate.longitude];
            
            min = fmin(min, dst);
            [self changeColor:0.01 min:0 actual:min];
        }
    }
}


#pragma coordinate geometry

-(float) calculatecrosstrack: (float) lat1 lat2:(float) lat2 lng1: (float) lng1 lng2:(float) lng2 lat3: (float)lat3 lng3: (float) lng3{
    
    if ( (lng3 <= lng1 && lng3 >= lng2)  || (lng3 >= lng1 && lng3 <= lng2)
        || (lat3 <= lat1 && lat3 >= lat2)  || (lat3 >= lat1 && lat3 <= lat2)){
        float d13  = [self calculatedistance: lat1 lat2:lat3 lng1:lng1  lng2:lng3];
        float o13  = [self calculatebearing: lat1  lat2:lat3 lng1:lng1 lng2: lng3];
        float o12  = [self calculatebearing:lat1  lat2:lat2  lng1:lng1  lng2:lng2];
        int R = 6371;
        
        float dxt = asin(sin(d13/R) * sin([self radians: (o13-o12)])) * R;
       
        return fabs(dxt);
    }
    
    return  fmin([self calculatedistance:lat1 lat2:lat3 lng1:lng1 lng2:lng3], [self calculatedistance:lat2 lat2:lat3 lng1:lng2 lng2:lng3]);

}

-(float) radians: (float) d{
    return d * M_PI / 180;
}

-(int) degrees: (float) r{
    return (int) (r * 180 / M_PI);
}

-(float) calculatedistance: (float) lat1 lat2:(float) lat2 lng1:(float)lng1 lng2:(float) lng2{
    int R = 6371;
    float dLat = [self radians: (lat2 - lat1)];
    float dLon = [self radians: (lng2 - lng1)];
    float rlat1 = [self radians: lat1];
    float rlat2 = [self radians: lat2];
    
    float a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(rlat1) * cos(rlat2);
    float c = 2 * atan2(sqrt(a), sqrt(1-a));
    return R * c;
}

-(int) calculatebearing: (float) lat1 lat2:(float) lat2 lng1:(float)lng1 lng2:(float) lng2{
    float dLon = [self radians: (lng2 - lng1)];
    float flat1 = [self radians:lat1];
    float flat2 = [self radians:lat2];
    float y = sin(dLon) * cos(flat2);
    float x = cos(flat1) * sin(flat2) - sin(flat1) * cos(flat2) * cos(dLon);
    float brng = atan2(y,x);
    return [self degrees: brng+360] % 360;
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


- (IBAction)back:(id)sender {
    [locationManager stopUpdatingLocation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
   RegistrationContainerViewController *container = (RegistrationContainerViewController*)[segue destinationViewController];
    
    NSLog(@"assigning development %@", self.development);


    container.development = self.development;
}



@end
