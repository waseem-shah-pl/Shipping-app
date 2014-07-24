//
//  MainScreen.m
//  Shipping
//
//  Created by Taimoor Ali on 23/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "MainScreen.h"

@interface MainScreen ()

@end

@implementation MainScreen

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    app = [[UIApplication sharedApplication]delegate];
    NSLog(@"app %@",app.userID);
}
-(void)viewWillAppear:(BOOL)animated {
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)LogOut:(id)sender {
    [app.nav popToRootViewControllerAnimated:YES];
}

-(IBAction)AboutMe:(id)sender {
    if (!vcAboutMe) {
        vcAboutMe = [[AboutMe alloc]initWithNibNameforIphone4:@"AboutMe" NibNameforIphone5:@"AboutMe" NibNameforIpad:@"AboutMeiPad" bundle:[NSBundle mainBundle]];
    }
    [app.nav pushViewController:vcAboutMe animated:YES];
}

-(IBAction)NewShipment:(id)sender {
    if (!vcScanCode) {
        vcScanCode = [[ScanCode alloc]initWithNibNameforIphone4:@"ScanCode4" NibNameforIphone5:@"ScanCode" NibNameforIpad:@"ScanCodeiPad" bundle:[NSBundle mainBundle]];
    }
    [app.nav pushViewController:vcScanCode animated:YES];
}

-(IBAction)AllShipment:(id)sender {
    if (!vcAllShipment) {
        vcAllShipment = [[AllShipment alloc]initWithNibNameforIphone4:@"AllShipment" NibNameforIphone5:@"AllShipment" NibNameforIpad:@"AllShipmentiPad" bundle:[NSBundle mainBundle] ];

    }
    vcAllShipment.isFirstTime= TRUE;
    [app.nav pushViewController:vcAllShipment animated:YES];
}



@end
