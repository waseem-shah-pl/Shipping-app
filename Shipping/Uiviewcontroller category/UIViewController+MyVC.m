//
//  UIViewController+MyVC.m
//  WebserviceCalling
//
//  Created by Waseem shah on 08/05/2014.
//  Copyright (c) 2014 Apple. All rights reserved.
//

#import "UIViewController+MyVC.h"

@implementation UIViewController (MyVC)

- (id)initWithNibNameforIphone4:(NSString *)nibNameOrNil4 NibNameforIphone5:(NSString *)nibNameOrNil5 NibNameforIpad:(NSString *)nibNameOrNilpad bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super init])
    {
        self = [self initWithNibName:[self CheckDeviceIphone4:nibNameOrNil4 Iphone5:nibNameOrNil5 Ipad:nibNameOrNilpad] bundle:nibBundleOrNil];
    }
    return self;

}

-(NSString *)CheckDeviceIphone4:(NSString *)iphone4 Iphone5:(NSString *)iphone5 Ipad:(NSString *)ipad {
    
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? ipad :([[UIScreen mainScreen] bounds].size.height == 568) ?  iphone5 :iphone4;
}

@end
