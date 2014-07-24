//
//  AppDelegate.h
//  Shipping
//
//  Created by Taimoor Ali on 17/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"

@class FirstScreen;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FirstScreen *vcFirst;
@property (strong, nonatomic) LoadingView *vcLoadingView;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong ,nonatomic) NSString *userName;
@property (strong ,nonatomic) NSString *password;
@property (strong ,nonatomic) NSString *userID;
@property (strong ,nonatomic) NSString *shipmentStatus;
@property (strong ,nonatomic) NSString *apiURL;

@end
