//
//  AboutMe.m
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "AboutMe.h"
#import "FinanceApi.h"

@interface AboutMe ()

@end

@implementation AboutMe

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
    cCommon=[[CommonFunction alloc]init];
 
}
-(void)viewWillAppear:(BOOL)animated {
   [app.window addSubview:app.vcLoadingView.view];
    [self performSelector:@selector(Callwebservice) withObject:nil afterDelay:0.3f];
}

-(void)Callwebservice {
    
    NSMutableDictionary *param=[NSMutableDictionary new];
    [param setValue:@"about_me" forKey:@"method"];
    [param setValue:app.userID forKey:@"driver_id"];
    
    NSDictionary *mainDict=[FinanceApi post:[NSString stringWithFormat:@"%@/drivers",app.apiURL] params:param];
    if ([mainDict[@"error"] boolValue]) {
        [cCommon ShowAlert:mainDict[@"message"] Title:@"Error"];
    }else {
        lblAddress.text=mainDict[@"data"][@"address"];
        lblCompany.text=mainDict[@"data"][@"company"];
        lblContactNumber.text=mainDict[@"data"][@"mobile_number"];
        lblDesiganation.text=mainDict[@"data"][@"designation"];
        lblEmail.text=mainDict[@"data"][@"email"];
        lblFirstName.text=mainDict[@"data"][@"first_name"];
        lblLastNAme.text=mainDict[@"data"][@"last_name"];
        lblPhoneNumber.text=mainDict[@"data"][@"phone_number"];
    }
    
    [self HideFadeView];
}

-(void)HideFadeView {
    [app.vcLoadingView.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)Back:(id)sender {
    [app.nav popViewControllerAnimated:YES];
}
@end
