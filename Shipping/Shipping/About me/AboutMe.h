//
//  AboutMe.h
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoadingView.h"
#import "CommonFunction.h"

@interface AboutMe : UIViewController {
    AppDelegate *app;
    LoadingView *vcLoading;
    CommonFunction *cCommon;
    
    IBOutlet UILabel *lblFirstName,*lblLastNAme;
    IBOutlet UILabel *lblDesiganation,*lblCompany;
    IBOutlet UILabel *lblEmail,*lblAddress;
    IBOutlet UILabel *lblContactNumber,*lblPhoneNumber;
}

@end
