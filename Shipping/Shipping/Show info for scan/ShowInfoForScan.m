//
//  ShowInfoForScan.m
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "ShowInfoForScan.h"

@interface ShowInfoForScan ()

@end

@implementation ShowInfoForScan
@synthesize imgScanImage;
@synthesize strScanText;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    scanImgview.image=self.imgScanImage;
    scanTextView.text=self.strScanText;
}
-(IBAction)BackBtn:(id)sender {
    [app.nav popViewControllerAnimated: YES];
}
-(IBAction)GoNextScreen:(id)sender {
    
    vcChooseOption = Nil;
    vcChooseOption = [[ChooseOptions alloc]initWithNibNameforIphone4:@"ChooseOptions4" NibNameforIphone5:@"ChooseOptions" NibNameforIpad:@"ChooseOptionsiPad" bundle:[NSBundle mainBundle]];
    
    
    vcChooseOption.strInfo=scanTextView.text;
    [app.nav pushViewController:vcChooseOption animated:YES];
}
@end
