//
//  ScanCode.m
//  Shipping
//
//  Created by Taimoor Ali on 17/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "ScanCode.h"
#import "FinanceApi.h"

@interface ScanCode ()

@end

@implementation ScanCode

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

-(IBAction)BackBtn:(id)sender {
    [app.nav popViewControllerAnimated:YES];
}

#pragma mark - Button click method

- (IBAction)startScanning:(id)sender {
    NSLog(@"Scanning..");
    ZBarReaderViewController *codeReader = [ZBarReaderViewController new];
    codeReader.readerDelegate=self;
    codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = codeReader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    [self presentViewController:codeReader animated:YES completion:nil];
    
}

#pragma mark - ZBar's Delegate method

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //  get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // just grab the first barcode
        break;
    
    // showing the result on textview
    strScanText = symbol.data;
    imgScanImage = [info objectForKey: UIImagePickerControllerOriginalImage];
    // dismiss the controller
    [reader dismissViewControllerAnimated:YES completion:nil];
    [self performSelector:@selector(CallWebService) withObject:nil afterDelay:0.3f];
}

-(void)ShowFadeView {
    [app.window addSubview:app.vcLoadingView.view];
}

-(void)HideFadeView {
    [app.vcLoadingView.view removeFromSuperview];
}

-(void)CallWebService{
    CommonFunction *commonFunction=[CommonFunction sharedManager];
    
    
    
    NSRange range =[strScanText rangeOfString:@"|"];
    
    if (range.length > 0) {
        NSThread *showThread=[[NSThread alloc]initWithTarget:self selector:@selector(ShowFadeView) object:Nil];
        [showThread start];
        NSMutableDictionary *param=[NSMutableDictionary new];
        [param setValue:@"check_shipment_if_assigned" forKey:@"method"];
        [param setValue:strScanText forKey:@"qr_value"];
        [param setValue:app.userID forKey:@"driver_id"];
        
        
        NSDictionary *mainDict=[FinanceApi post:[NSString stringWithFormat:@"%@/shipments",app.apiURL] params:param];
        NSLog(@"main Dict %@",mainDict);
        NSLog(@"info %@",mainDict[@"data"][@"status"]);
        if (mainDict[@"data"][@"status"]) {
            app.shipmentStatus=mainDict[@"data"][@"status"];
        }
        
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
        
        if ([[mainDict valueForKey:@"error"] boolValue]) {
            [commonFunction ShowAlert:[mainDict valueForKey:@"message"] Title:@"Error"];
        }else {
            [self performSelector:@selector(MoveNextScreen) withObject:nil afterDelay:0.3f];
        }

    }else {
        [commonFunction ShowAlert:@"Please scan valid shipment QR Code." Title:@"Error"];
    }
    
    
  
}

-(void)MoveNextScreen{
    if(!vcShowInfo) {
        vcShowInfo = [[ShowInfoForScan alloc]initWithNibNameforIphone4:@"ShowInfoForScan4" NibNameforIphone5:@"ShowInfoForScan" NibNameforIpad:@"ShowInfoForScaniPad" bundle:[NSBundle mainBundle]];
    }
    vcShowInfo.imgScanImage=imgScanImage;
    vcShowInfo.strScanText=strScanText;
    [app.nav pushViewController:vcShowInfo animated:YES];
        
}
@end
