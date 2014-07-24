//
//  FinanceApi.m
//  Mobile Finance
//
//  Created by Taimoor Ali on 3/25/14.
//  Copyright (c) 2013 Taimoor Ali. All rights reserved.
//

#import "FinanceApi.h"
#import "Reachability.h"
#import "NS+WebToolkit.h"

@implementation FinanceApi

+ (NSDictionary *) get:(NSString *) call params:(NSMutableDictionary *) params {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLRequest *request = [FinanceApi getRequest:call method:@"GET" params:params];
    
    NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    return [data json_decode];
    
}

+ (NSDictionary *) get: (NSString *) call params:(NSMutableDictionary *) params responseHandler:(void (^)(id data))handler {
    
  	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLRequest *request = [FinanceApi getRequest:call method:@"GET" params:params];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                              
                               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                handler([data json_decode]);
                           }
     ];
    return Nil;
    
}

+ (NSURLRequest *) getRequest:(NSString *) call method:(NSString *)method params:(NSMutableDictionary *) params{
    

    
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    NSString *url_string = [NSString stringWithFormat:@"%@", call];

    NSLog(@"REQUEST URL: %@", url_string);
    
    NSURL* requestURL = [NSURL URLWithString: url_string];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:120.0];
    [request setHTTPMethod:method];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    

    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
   
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setURL:requestURL];
    
    return request;
    
}

+ (NSDictionary *) post:(NSString *) call params:(NSMutableDictionary *) params{
   	
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Connection not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            NSURLRequest *request = [FinanceApi getRequest:call method:@"POST" params:params];
            
            NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
            
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            return [data json_decode];
    }
    return Nil;
}

+ (void) post:(NSString *) call params:(NSMutableDictionary *) params images:(NSMutableDictionary *) images responseHandler:(void (^)(id data))handler {
   	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLRequest *request = [FinanceApi getRequest:call method:@"POST" params:params];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                               NSString* myString;
                               myString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                               NSLog(@"%@",myString);
                               handler([data json_decode]);
                           }
     ];
}

+ (id) getURLString:(NSString *) call params:(NSMutableDictionary *) params {
    
    NSString *_url = [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%@", call],params];
    return  _url;
    
}



@end
