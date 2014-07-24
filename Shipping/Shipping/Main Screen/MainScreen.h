//
//  MainScreen.h
//  Shipping
//
//  Created by Taimoor Ali on 23/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ScanCode.h"
#import "AboutMe.h"
#import "AllShipment.h"

@interface MainScreen : UIViewController{
    AppDelegate *app;
    ScanCode *vcScanCode;
    AboutMe *vcAboutMe;
    AllShipment *vcAllShipment;
    
}

@end
