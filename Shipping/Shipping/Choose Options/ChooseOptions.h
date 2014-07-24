//
//  ChooseOptions.h
//  Shipping
//
//  Created by Taimoor Ali on 18/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "ThanksPage.h"
#import "CommonFunction.h"
#import "ZBarSDK.h"


@interface ChooseOptions : UIViewController <UIPickerViewDataSource , UIPickerViewDelegate,CLLocationManagerDelegate,ZBarReaderDelegate>
{
    AppDelegate *app;
    ThanksPage *vcThanks;
    CommonFunction *common;

    IBOutlet UIPickerView *pickerViewOption;
    IBOutlet UILabel *lblOption;
    
    CLLocationManager *locationManager;
    
    
    float flat,flong;
    BOOL isCall;
    NSMutableArray *arrayOptions;
    
    
}
@property (strong ,nonatomic) NSString *strInfo;
@end
