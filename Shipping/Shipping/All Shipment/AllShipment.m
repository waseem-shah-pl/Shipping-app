//
//  AllShipment.m
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "AllShipment.h"
#import "FinanceApi.h"
#import "Webservice.h"
#import "NVPolylineAnnotation.h"
#import "MapAnnotation.h"
#import "NVPolylineAnnotationView.h"
#import "ShowTime.h"

@interface AllShipment () {
    int totalRecords;
     NSMutableArray *points;
    NSMutableArray *dummyArray;
}

@end

@implementation AllShipment
@synthesize isFirstTime;
@synthesize PathChoose;
@synthesize mainArray;

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
    // Do any additional setup after loading the view from its nib.
    app = [[UIApplication sharedApplication] delegate];
    cCommon=[[CommonFunction alloc]init];
    mapView.showsUserLocation=TRUE;
    
   
}
-(void)viewWillAppear:(BOOL)animated {
    [mapView removeAnnotations:mapView.annotations];
    NSLog(@"isfrirstTime %d",isFirstTime);
    if (isFirstTime) {
        totalRecords = 0;
        mainArray =[[NSMutableArray alloc]init];
        dummyArray=[[NSMutableArray alloc]init];;
        [app.window addSubview:app.vcLoadingView.view];
        
        [self performSelector:@selector(CallwebserviceGetAllShipment) withObject:Nil afterDelay:0.2f];
    } else {
        points = [[NSMutableArray alloc]init];
        [self WebServiceCallForPath];
    }
}

-(void)WebServiceCallForPath{
    
    for (int index= 0; index < mainArray.count; index++) {
        
        [points addObject:[[CLLocation alloc] initWithLatitude:[mainArray[index][@"start_location"][@"lat"] doubleValue] longitude:[mainArray[index][@"start_location"][@"lng"] doubleValue]]];
    }
    [self SetRegion];
    NSLog(@"point %d",points.count);
    NVPolylineAnnotation *annotation = [[NVPolylineAnnotation alloc] initWithPoints:points mapView:mapView] ;
	[mapView addAnnotation:annotation];
//    MKCoordinateRegion region;
//	region.span.longitudeDelta = [mainArray[mainArray.count-1][@"start_location"][@"lng"] doubleValue];
//	region.span.latitudeDelta = [mainArray[mainArray.count-1][@"start_location"][@"lat"] doubleValue];
//	region.center.latitude = [mainArray[0][@"start_location"][@"lat"] doubleValue];
//	region.center.longitude = [mainArray[0][@"start_location"][@"lng"] doubleValue];
//	[mapView setRegion:region];
    
    
    
}
-(IBAction)BackBtn:(id)sender {
    [app.nav popViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CallwebserviceGetAllShipment{
    NSMutableDictionary *param=[NSMutableDictionary new];
    [param setValue:@"my_shipments" forKey:@"method"];
    [param setValue:app.userID forKey:@"driver_id"];
    
    NSDictionary *mainDict=[FinanceApi post:[NSString stringWithFormat:@"%@/shipments",app.apiURL] params:param];
    NSLog(@"Main Dict %@",mainDict);
    if ([mainDict[@"error"] boolValue]) {
        [cCommon ShowAlert:mainDict[@"message"] Title:@"Error"];
        [self HideFadeView];
    }else {
        mainArray = mainDict[@"data"];
        if (mainArray.count > 0) {
         [self GetAllLatLong];
        }else {
            [cCommon ShowAlert:@"No shipment." Title:@"Error"];
            [self HideFadeView];
        }
        
        
        
    }
}


- (void)mapView:(MKMapView *)mapView1 didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (isFirstTime) {
        mapView.centerCoordinate = userLocation.location.coordinate;
    } else {
        
    }

}



-(void)GetAllLatLong {
    for (int index = 0 ; index < mainArray.count; index++) {
        
        NSDictionary *maindict=[Webservice callWebservice:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=%@",mainArray[index][@"destination"]]];
        CLLocationCoordinate2D annotationCoord;
        annotationCoord.latitude = [maindict[@"results"][0][@"geometry"][@"location"][@"lat"] doubleValue];
        annotationCoord.longitude = [maindict[@"results"][0][@"geometry"][@"location"][@"lng"] doubleValue];
        
        NSMutableDictionary *dummyDict=[NSMutableDictionary new];
        [dummyDict setValue:[NSString stringWithFormat:@"%f",[maindict[@"results"][0][@"geometry"][@"location"][@"lat"] doubleValue]] forKey:@"lat"];
        [dummyDict setValue:[NSString stringWithFormat:@"%f",[maindict[@"results"][0][@"geometry"][@"location"][@"lng"] doubleValue]] forKey:@"long"];
        [dummyDict setValue:mainArray[index][@"destination"] forKey:@"destination"];
        [dummyDict setValue:mainArray[index][@"description"] forKey:@"description"];
        [dummyDict setValue:mainArray[index][@"origion"] forKey:@"origion"];
        [dummyArray addObject:dummyDict];
        if (index+1 == mainArray.count) {

            [self performSelector:@selector(SetRegion) withObject:Nil afterDelay:0.1f];
        }
    }


}

-(void)SetRegion {
    if (_locManager == nil){
        _locManager = [[CLLocationManager alloc]init];
        _locManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locManager.delegate = self;
        
        _locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _locManager.distanceFilter = 10;
        [_locManager startUpdatingLocation];
        
    }

    NSLog(@"SetRegion");
    if (isFirstTime) {
        
        for (int index = 0; index < dummyArray.count; index++) {
            
            NSMutableDictionary *dummyDict=dummyArray[index] ;
            
            CLLocationCoordinate2D annotationCoord;
            annotationCoord.latitude =[dummyDict[@"lat"] doubleValue];
            annotationCoord.longitude=[dummyDict[@"long"] doubleValue];
            
            MapAnnotation* annotation = [[MapAnnotation alloc] initWithCoordinate:annotationCoord];
            annotation.titleStr = dummyDict[@"destination"];
            
            annotation.subTitleStr = dummyDict[@"description"];
            annotation.val = index;
            [mapView addAnnotation:annotation];
            
            
        }
        NSLog(@"HideFadeView");
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
    } else {
        CLLocationCoordinate2D location;
        location.latitude = [mainArray[mainArray.count-1][@"end_location"][@"lat"] doubleValue];
        location.longitude = [mainArray[mainArray.count-1][@"end_location"][@"lng"] doubleValue];
        MapAnnotation* annotation = [[MapAnnotation alloc] initWithCoordinate:location];
        annotation.titleStr = @"Title";
        
        annotation.subTitleStr = [NSString stringWithFormat:@"Lahore"];
        annotation.val = 1;
        [mapView addAnnotation:annotation];
        
//        CLLocationCoordinate2D startCoord1 = CLLocationCoordinate2DMake(location.latitude, location.longitude);
//        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord1, 50000, 50000)];
//        [mapView setRegion:adjustedRegion animated:YES];

    }
    
	
    
}

- (void)mapView:(MKMapView *)mapView1 annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    if (isFirstTime) {
        MapAnnotation *annotation = (MapAnnotation *)view.annotation;
        
        ShowTime *vcShowTime=[[ShowTime alloc]initWithNibNameforIphone4:@"ShowTime" NibNameforIphone5:@"ShowTime" NibNameforIpad:@"ShowTimeiPad" bundle:[NSBundle mainBundle]];
        vcShowTime.mainDict=dummyArray[annotation.val];
        vcShowTime.userLocationLat=[NSString stringWithFormat:@"%f",mapView.userLocation.location.coordinate.latitude];
        vcShowTime.userLocationLong=[NSString stringWithFormat:@"%f",mapView.userLocation.location.coordinate.longitude];
        vcShowTime.allShipment=self;
        [app.nav pushViewController:vcShowTime animated:YES];
    }
   

}


- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id < MKAnnotation >)annotation
{
    if (isFirstTime) {
        if([annotation isKindOfClass:[MKUserLocation class]])
            return nil;
        
        static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
        
        {
            MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                            reuseIdentifier:AnnotationIdentifier] ;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pinRed.png"]];
            UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            annotationView.rightCalloutAccessoryView = rightButton;
            annotationView.canShowCallout = YES;
            annotationView.draggable = YES;
            return annotationView;
        }

    } else {
        if ([annotation isKindOfClass:[NVPolylineAnnotation class]]) {
            return [[NVPolylineAnnotationView alloc] initWithAnnotation:annotation mapView:mapView];
        }
        
        
        
        if([annotation isKindOfClass:[MKUserLocation class]])
            return nil;
        
        static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        
        if(annotationView)
            return annotationView;
        else
        {
            MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                            reuseIdentifier:AnnotationIdentifier] ;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pinRed.png"]];
            annotationView.draggable = YES;
            return annotationView;
            
        }

    }
    return nil;
}



-(void)HideFadeView {
    [app.vcLoadingView.view removeFromSuperview];
}

@end
