//
//  NS+WebToolkit.m
//  Cinex
//
//  Created by Taimoor Ali on 6/19/13.
//  Copyright (c) 2013 Taimoor Ali. All rights reserved.
//

#import "NS+WebToolkit.h"
#import "JSONKit.h"

@implementation NSArray (WebToolkit)

- (NSString*) json_encode
{
//    return json_encode(self);
    return [self JSONString];
}

@end

@implementation NSDictionary (WebToolkit)

- (NSString*) json_encode
{
//    return json_encode(self);
    return [self JSONString];
}

- (NSString *)query_string
{
    NSMutableString *query_string = nil;
    NSArray *keys = [self allKeys];
    
    if ([keys count] > 0) {
        for (id key in keys) {
            id value = [self objectForKey:key];
            if (nil == query_string) {
                query_string = [[NSMutableString alloc] init];
                [query_string appendFormat:@"?"];
            } else {
                [query_string appendFormat:@"&"];
            }
            
            if (nil != key && nil != value) {
                [query_string appendFormat:@"%@=%@", [key url_encode], [[NSString stringWithFormat:@"%@", value] url_encode]];
            } else if (nil != key) {
                [query_string appendFormat:@"%@", [key url_encode]];
            }
        }
    }
    return query_string;
}

@end

@implementation NSData (WebToolkit)

- (id) json_decode {
    // TO USE built in NSJSONSerialization
//    NSError* error = nil;
//    id result = [NSJSONSerialization JSONObjectWithData:self
//                                                options:NSJSONReadingMutableContainers error:&error];
//    if (error != nil) return nil;
    id result = [self mutableObjectFromJSONData];
    return result;
}

@end

@implementation NSString (WebToolkit)
/*
- (NSString *) md5 {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}*/

- (NSString*) url_encode
{
    NSString *encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                           NULL,
                                                                                           (CFStringRef)self,
                                                                                           NULL,
                                                                                           (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                           kCFStringEncodingUTF8 );
    return encodedString;
}

- (NSString*) url_decode {
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         (__bridge CFStringRef) self,
                                                                                         CFSTR(""),
                                                                                         kCFStringEncodingUTF8);
}

- (NSDictionary*) parse_query_string {
    NSMutableDictionary *query_params = [NSMutableDictionary dictionary];
    
    if([self rangeOfString:@"?"].location != NSNotFound) {
        NSString *querystring = [[self componentsSeparatedByString:@"?"] objectAtIndex:1];
        
        NSArray *parameters = [[querystring url_decode] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        
        for (int i = 0; i < [parameters count]; i=i+2) {
            [query_params setObject:[parameters objectAtIndex:i+1] forKey:[parameters objectAtIndex:i]];
        }
    }
    return query_params;
}

@end