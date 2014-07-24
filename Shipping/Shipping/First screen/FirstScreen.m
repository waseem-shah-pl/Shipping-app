//
//  FirstScreen.m
//  Shipping
//
//  Created by Taimoor Ali on 17/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "FirstScreen.h"
#import "CommonFunction.h"
#import "FinanceApi.h"



#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface FirstScreen ()

@end

@implementation FirstScreen

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
-(void)viewWillAppear:(BOOL)animated {
    self.txtFeildName.text=self.txtFeildPassword.text=@"";
    self.txtFeildName.text=@"faisal.sial@gmail.com";
    self.txtFeildPassword.text=@"12345678";
    [self.txtFeildPassword resignFirstResponder];
    [self.txtFeildName resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        
        if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            // code here
            [self ChangeViewCenter:CGPointMake(160, 230)];
        }else {
            [self ChangeViewCenter:CGPointMake(160, 240)];
        }
        
        
    }

    return TRUE;
}

-(void)ShowFadeView {
    [app.window addSubview:app.vcLoadingView.view];
}

-(void)HideFadeView {
    [app.vcLoadingView.view removeFromSuperview];
}

-(IBAction)PushScanView:(id)sender {
    [self.txtFeildName resignFirstResponder];
    [self.txtFeildPassword resignFirstResponder];
    CommonFunction *commonFunction=[CommonFunction sharedManager];

    
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            // code here
            [self ChangeViewCenter:CGPointMake(160, 230)];
        }else {
            [self ChangeViewCenter:CGPointMake(160, 240)];
        }
    }
    
    if (self.txtFeildName.text.length > 0 && self.txtFeildPassword.text.length > 0) {
        
        NSThread *showThread=[[NSThread alloc]initWithTarget:self selector:@selector(ShowFadeView) object:Nil];
        [showThread start];
        
        
        NSMutableDictionary *param=[NSMutableDictionary new];
        [param setValue:@"login" forKey:@"method"];
        [param setValue:self.txtFeildName.text forKey:@"user_name"];
        [param setValue:self.txtFeildPassword.text forKey:@"password"];
        
        
        NSDictionary *mainDict=[FinanceApi post:[NSString stringWithFormat:@"%@/drivers",app.apiURL] params:param];
        NSLog(@"main Dict %@",mainDict);
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
        if (mainDict) {
            if ([[mainDict valueForKey:@"error"] boolValue]) {
                [commonFunction ShowAlert:[mainDict valueForKey:@"message"] Title:@"Error"];
            }else {
                if (!vcMain) {
                    vcMain= [[ MainScreen alloc]initWithNibNameforIphone4:@"MainScreen" NibNameforIphone5:@"MainScreen" NibNameforIpad:@"MainScreeniPad"  bundle:[NSBundle mainBundle]];
                }
                app.password=self.txtFeildPassword.text;
                app.userName=self.txtFeildName.text;
                app.userID = [[mainDict valueForKey:@"data"] valueForKey:@"driver_id"];
                [app.nav pushViewController:vcMain animated:YES];
                
            }
        }else {
             [commonFunction ShowAlert:@"Please check internet connection" Title:@"Error"];
        }
        
    }else {
        [commonFunction ShowAlert:@"Please give any username and password" Title:@"Error"];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([UIScreen mainScreen].bounds.size.height == 480 && self.view.center.y > 160) {
        [self ChangeViewCenter:CGPointMake(160, 150)];
    }
}

- (void)ChangeViewCenter:(CGPoint)center{
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        self.view.center =center;
        [UIView commitAnimations];
    }
    
}
@end
