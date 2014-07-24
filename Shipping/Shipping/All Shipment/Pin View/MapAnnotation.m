//
//  MapAnnotation.m
//  Elections 2013
//
//  Created by apple on 4/15/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation
@synthesize coordinate = _coordinate;
@synthesize titleStr;
@synthesize subTitleStr;
@synthesize val;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
	
    if (self != nil)
    {
        _coordinate = coordinate;
    }
	
    return self;
}

- (NSString *)title
{
	return titleStr;
}

- (NSString *)subtitle
{
	return subTitleStr;
}

@end