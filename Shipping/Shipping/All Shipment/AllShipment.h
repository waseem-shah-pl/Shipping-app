//
//  AllShipment.h
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CommonFunction.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface AllShipment : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    AppDelegate *app;
    CommonFunction *cCommon;

    IBOutlet MKMapView *mapView;
    NSMutableArray *mainArray;
    CLLocationManager * _locManager;
}
@property BOOL isFirstTime;
@property int PathChoose;
@property (strong , nonatomic) NSMutableArray *mainArray;
@end
