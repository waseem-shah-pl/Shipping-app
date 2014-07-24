//
//  ShowInfoForScan.h
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ChooseOptions.h"

@interface ShowInfoForScan : UIViewController {
    AppDelegate *app;
    ChooseOptions *vcChooseOption;
    
    IBOutlet UIImageView *scanImgview;
    IBOutlet UITextView *scanTextView;
    
}
@property(strong , nonatomic) NSString *strScanText;
@property(strong , nonatomic) UIImage *imgScanImage;
@end
