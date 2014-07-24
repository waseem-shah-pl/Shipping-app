//
//  ThanksPage.m
//  Shipping
//
//  Created by Taimoor Ali on 24/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "ThanksPage.h"
#import "MainScreen.h"

@interface ThanksPage ()

@end

@implementation ThanksPage

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

-(IBAction)ReturnToMainPage:(id)sender {
   
        
        for (UIViewController *controller in app.nav.viewControllers) {
            
            //Do not forget to import AnOldViewController.h
            if ([controller isKindOfClass:[MainScreen class]]) {
                
                [app.nav popToViewController:controller animated:YES];
                break;
            }
        }
        
   
}
@end
