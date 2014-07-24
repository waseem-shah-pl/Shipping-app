//
//  ShowTime.m
//  Shipping
//
//  Created by Taimoor Ali on 09/07/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "ShowTime.h"
#import "Webservice.h"
#import "CustomCellForTime.h"
#import "AllShipment.h"

@interface ShowTime (){
    NSString *userPlace;
}

@end

@implementation ShowTime
@synthesize mainDict;
@synthesize userLocationLat,userLocationLong;
@synthesize allShipment;

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
    [app.window addSubview:app.vcLoadingView.view];
    mainArray = [[NSMutableArray alloc]init];
    NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(Callwebservice) object:Nil];
    [hideThread start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)BackBtn:(id)sender {
    [app.nav popViewControllerAnimated:YES];
}



-(void)Callwebservice{
    NSDictionary *maindict=[Webservice callWebservice:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",self.userLocationLat,self.userLocationLong]];
    if (mainDict) {
        userPlace = maindict[@"results"][0][@"formatted_address"];
        [self CallWebServiceForTimeTravel];
    } else {
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
    }
    
   
    
}
-(void)CallWebServiceForTimeTravel{
    NSDictionary *maindict=[Webservice callWebservice:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&alternatives=true&sensor=false&mode=driving",self.mainDict[@"origion"],self.mainDict[@"destination"]]];
    if (maindict) {
        mainArray = maindict[@"routes"];
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
    } else {
        NSThread *hideThread=[[NSThread alloc]initWithTarget:self selector:@selector(HideFadeView) object:Nil];
        [hideThread start];
    }


}

-(void)HideFadeView {
    [mainTbleView reloadData];
    [app.vcLoadingView.view removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mainArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellShopping";
    
    NSString *xibName;
    if ([UIScreen mainScreen].bounds.size.height > 600) {
        xibName=@"CustomCellForTimeiPad";
    }else {
         xibName=@"CustomCellForTime";
    }
    
    CustomCellForTime  *cell = (CustomCellForTime *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        NSArray  *nibObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
        for(id currObject in nibObjects)
        {
            if([currObject isKindOfClass:[CustomCellForTime class]])
            {
                cell = (CustomCellForTime *)currObject;
            }
        }
    }
    cell.backgroundColor=[UIColor clearColor];
    NSMutableDictionary *mainDict1=mainArray[indexPath.row];

    cell.lblTime.text=mainDict1[@"legs"][0][@"duration"][@"text"];
    cell.lblDistance.text=mainDict1[@"legs"][0][@"distance"][@"text"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.allShipment.isFirstTime=FALSE;
    self.allShipment.PathChoose=indexPath.row;
    self.allShipment.mainArray=mainArray[indexPath.row][@"legs"][0][@"steps"];
    [app.nav popViewControllerAnimated:NO];
}
@end
