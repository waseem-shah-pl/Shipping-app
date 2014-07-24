//
//  CustomCellForTime.m
//  Shipping
//
//  Created by Taimoor Ali on 10/07/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "CustomCellForTime.h"

@interface CustomCellForTime ()

@end

@implementation CustomCellForTime
@synthesize lblTime;
@synthesize lblDistance;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Custom initialization
    }
    return self;
}

@end
