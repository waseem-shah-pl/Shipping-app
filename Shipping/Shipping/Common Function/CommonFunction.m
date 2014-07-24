//
//  CommonFunction.m
//  Shipping
//
//  Created by Taimoor Ali on 18/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction


+ (id)sharedManager {
    static CommonFunction *sharedMyCommon = nil;
    @synchronized(self) {
        if (sharedMyCommon == nil)
            sharedMyCommon = [[self alloc] init];
    }
    return sharedMyCommon;
}


-(void)ShowAlert:(NSString *)_body Title:(NSString *)_title
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:_title message:_body delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
