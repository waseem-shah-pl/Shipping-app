//
//  Webservice.h
//  WebserviceCalling
//
//  Created by Apple on 9/6/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"

@interface Webservice : NSObject
{
    
}

+(NSDictionary*) callWebservice : (NSString*)url;
@end
