//
//  Webservice.m
//  WebserviceCalling
//
//  Created by Apple on 9/6/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "Webservice.h"
#import "Reachability.h"

@implementation Webservice
+(NSDictionary*) callWebservice : (NSString*)url
{
    NSDictionary  *dictionary = nil;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Connection not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {

        if (url!=nil && ![url isEqualToString:@""]) {
            NSLog(@"URl : %@",url);
            NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            
            NSError *error = nil;
            NSString *resultData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            dictionary = [[[SBJSON alloc] init] objectWithString:resultData error:&error];
            
            if (dictionary == nil)
            {

                NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                
                NSError *error = nil;
                NSString *resultData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                dictionary = [[[SBJSON alloc] init] objectWithString:resultData error:&error];
                
            }
        }
    }
    return dictionary;
}

@end
