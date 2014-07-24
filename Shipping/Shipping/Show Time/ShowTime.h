//
//  ShowTime.h
//  Shipping
//
//  Created by Taimoor Ali on 09/07/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class AllShipment;
@interface ShowTime : UIViewController<UITableViewDataSource ,UITableViewDelegate> {
    AppDelegate *app;
    
    IBOutlet UITableView *mainTbleView;
    
    NSMutableArray *mainArray;
}
@property (strong , nonatomic) NSString *userLocationLat;
@property (strong , nonatomic) AllShipment *allShipment;
@property (strong , nonatomic) NSString *userLocationLong;
@property (strong , nonatomic) NSMutableDictionary *mainDict;
@end
