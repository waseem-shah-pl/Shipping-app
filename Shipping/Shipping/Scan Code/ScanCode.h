//
//  ScanCode.h
//  Shipping
//
//  Created by Taimoor Ali on 17/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "ShowInfoForScan.h"
#import "AppDelegate.h"
#import "CommonFunction.h"

@interface ScanCode : UIViewController<ZBarReaderDelegate>
{
    AppDelegate *app;
    ShowInfoForScan *vcShowInfo;
    
    NSString *strScanText;
    UIImage *imgScanImage;
}

@end
