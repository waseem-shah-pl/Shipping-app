//
//  MapAnnotation.h
//  Elections 2013
//
//  Created by apple on 4/15/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation  : NSObject <MKAnnotation> {
    CLLocationCoordinate2D _coordinate;
	NSString * titleStr;
    NSString *subTitleStr;
    int val;
}
@property int val;
@property (nonatomic, retain) NSString * titleStr;
@property (nonatomic, retain) NSString * subTitleStr;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
