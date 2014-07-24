//
//  CommonFunction.h
//  Shipping
//
//  Created by Taimoor Ali on 18/06/2014.
//  Copyright (c) 2014 Waseem shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunction : NSObject {
    
}
+ (id)sharedManager;
-(void)ShowAlert:(NSString *)_body Title:(NSString *)_title;
@end
