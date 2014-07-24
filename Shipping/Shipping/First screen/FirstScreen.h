//
//  FirstScreen.h
//  Shipping
//
//  Created by Taimoor Ali on 17/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MainScreen.h"


@interface FirstScreen : UIViewController<UITextFieldDelegate> {
    AppDelegate *app;
    MainScreen *vcMain;
    
}
@property (strong , nonatomic) IBOutlet UITextField *txtFeildName;
@property (strong , nonatomic) IBOutlet UITextField *txtFeildPassword;

@end
