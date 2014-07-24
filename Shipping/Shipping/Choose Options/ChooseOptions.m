//
//  ChooseOptions.m
//  Shipping
//
//  Created by Taimoor Ali on 18/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "ChooseOptions.h"
#import "Webservice.h"
#import "FinanceApi.h"

@interface ChooseOptions ()
{
    NSString *processType,*newScanValue;;
    NSString *status,*shipmentID;
    double distnceInMeter;
    
}
@end

@implementation ChooseOptions
@synthesize  strInfo;

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
    status= @"1";
    common=[[CommonFunction alloc]init];
    [self RefreshOptions];
    [pickerViewOption reloadAllComponents];
    
    
    switch ([app.shipmentStatus intValue]) {
        case 1:
                lblOption.text=@"pending";
            break;
            case 2:
                lblOption.text=@"on road";
            break;
            
            
            case 3:
                lblOption.text=@"sign off";
            break;
        default:
                lblOption.text=@"pending";
            break;
    }
    
    

    [self GetShipmentID:self.strInfo];
    distnceInMeter=1000;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)RefreshOptions {
    arrayOptions = [NSMutableArray new];
    [arrayOptions addObject:@"pending"];
    [arrayOptions addObject:@"on road"];
    [arrayOptions addObject:@"sign off"];
}
-(void)ShowFadeView {
    [app.window addSubview:app.vcLoadingView.view];
}

-(void)HideFadeView {
    [app.vcLoadingView.view removeFromSuperview];
}

-(IBAction)ChangeStatus:(id)sender {
    pickerViewOption.hidden=FALSE;
    [pickerViewOption reloadAllComponents];
    
}
-(void)MoveNextScreenForThanks{
    NSThread *showThread=[[NSThread alloc]initWithTarget:self selector:@selector(ShowFadeView) object:Nil];
    [showThread start];
    
    
    NSMutableDictionary *param=[NSMutableDictionary new];
    [param setValue:@"assign_shipment_to_driver" forKey:@"method"];
    [param setValue:app.userID forKey:@"driver_id"];
    [param setValue:self.strInfo forKey:@"qr_value"];
    [param setValue:status forKey:@"status"];
    
    NSDictionary *mainDict=[FinanceApi post:[NSString stringWithFormat:@"%@/shipments",app.apiURL] params:param];
    NSLog(@"main Dict %@",mainDict);
    NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
    [hideThread start];
    
    if ([[mainDict valueForKey:@"error"] boolValue]) {
        [common ShowAlert:[mainDict valueForKey:@"message"] Title:@"Error"];
    }else {

        if (!vcThanks) {
            vcThanks = [[ThanksPage alloc]initWithNibNameforIphone4:@"ThanksPage" NibNameforIphone5:@"ThanksPage" NibNameforIpad:@"ThanksPageiPad" bundle:[NSBundle mainBundle]];
        }
        [app.nav pushViewController:vcThanks animated:YES];
        
        
    }
    

}

-(IBAction)MoveNextScreen:(id)sender {
    
    [self MoveNextScreenForThanks];
    
}
-(IBAction)BackBtn:(id)sender {
    [app.nav popViewControllerAnimated:YES];
}

#pragma mark UIpicker View DataSource 
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return arrayOptions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return arrayOptions[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    

    pickerViewOption.hidden=TRUE;
    

    
    switch (row) {
        case 0:
            status = @"1";
            lblOption.text=arrayOptions[row];
            break;
            
            case 1:
            status = @"2";
            [self CurrentLocationIdentifier];
            lblOption.text=arrayOptions[row];
            break;
            case 2:

            if (distnceInMeter < 100) {
                status = @"3";
                lblOption.text=arrayOptions[row];
                [self ScanCodeAgain];
            }else {
                [common ShowAlert:@"Please choose signoff when you reached on destination." Title:@"Error"];
            }
            break;
            
            
        default:
            break;
    }
    
}
-(void)ScanCodeAgain {
    ZBarReaderViewController *codeReader = [ZBarReaderViewController new];
    codeReader.readerDelegate=self;
    codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = codeReader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    [self presentViewController:codeReader animated:YES completion:nil];

}

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //  get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // just grab the first barcode
        break;
    
    // showing the result on textview
    newScanValue = symbol.data;

    // dismiss the controller
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    if ([newScanValue isEqualToString:self.strInfo]) {
         [self performSelector:@selector(MoveNextScreenForThanks) withObject:nil afterDelay:0.3f];
    }else{
        [common ShowAlert:@"Please scan correct shipemnt." Title:@"Error"];
    }

}


-(void)GetShipmentID:(NSString *)myString {
    NSRange range =[myString rangeOfString:@"|"];
    shipmentID=[myString substringToIndex:range.location];
  

}

#pragma mark Location Manager

-(void)CurrentLocationIdentifier
{
    NSLog(@"CurrentLocationIdentifier");
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLLocationAccuracyBest;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    //------
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    NSLog(@"didUpdateToLocation %d",state);
    if (state == UIApplicationStateActive)
    {
        processType = @"ios6 Loc ACTIVE";
        [self updateLocationToServerInForground:newLocation];
    }
    else
    {
        processType = @"ios6 Loc BACK";
        [self sendBackgroundLocationToServer:newLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = (CLLocation *)[locations objectAtIndex:locations.count-1];
    NSLog(@"newLocation = %f",newLocation.coordinate.latitude);
    flat=newLocation.coordinate.latitude;
    flong=newLocation.coordinate.longitude;
    
    
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateActive)
    {
         NSLog(@"ios7 Loc ACTIVE");
        processType = @"ios7 Loc ACTIVE";
        [self updateLocationToServerInForground:newLocation];
    }
    else
    {
         NSLog(@"ios7 Loc BACK");
        processType = @"ios7 Loc BACK";
        [self sendBackgroundLocationToServer:newLocation];
    };
}
-(void)callWeb {
    if (!isCall) {
         isCall= TRUE;
        NSLog(@"ios7 Loc callWeb");
        
        NSMutableDictionary *param=[NSMutableDictionary new];
        [param setValue:@"track_shipment" forKey:@"method"];
        [param setValue:app.userID forKey:@"driver_id"];
        [param setValue:[NSString stringWithFormat:@"%f",flat] forKey:@"lat"];
        [param setValue:[NSString stringWithFormat:@"%f",flong] forKey:@"long"];
        [param setValue:shipmentID forKey:@"shipment_id"];
        
        NSDictionary *mainDict=[FinanceApi post:[NSString stringWithFormat:@"%@/tracking",app.apiURL] params:param];
        NSLog(@"main Dict callWeb%@",mainDict);
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
        
        if ([[mainDict valueForKey:@"error"] boolValue]) {
            
        }else {
            distnceInMeter =[mainDict[@"data"][@"dist_to_dest_in_meters"] doubleValue];
        }
         isCall= FALSE;
    }
    
}
-(void)updateLocationToServerInForground:(CLLocation *)newLocation
{
    
    NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(callWeb) object:Nil];
    [t start];
}

- (void)sendBackgroundLocationToServer: (CLLocation *) lc
{
    if(TRUE)
    {
        UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
        
        bgTask = [[UIApplication sharedApplication]
                  beginBackgroundTaskWithExpirationHandler:^{
                      [[UIApplication sharedApplication] endBackgroundTask:bgTask];
                  }];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:2];
        [dictionary setObject:[NSNumber numberWithDouble:lc.coordinate.latitude] forKey:@"floLatitude"];
        [dictionary setObject:[NSNumber numberWithDouble:lc.coordinate.longitude] forKey:@"floLongitude"];
        NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(callWeb) object:Nil];
        [t start];
        
        if (bgTask != UIBackgroundTaskInvalid)
        {
            [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        }
    }
}
@end
