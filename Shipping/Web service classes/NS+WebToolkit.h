//
//  NS+WebToolkit.h
//  Cinex
//
//  Created by Taimoor Ali on 6/19/13.
//  Copyright (c) 2013 Taimoor Ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WebToolkit)

- (NSString*) json_encode;

@end

@interface NSDictionary (WebToolkit)

- (NSString*) json_encode;
- (NSString *)query_string;

@end

@interface NSData (WebToolkit)

- (id) json_decode;

@end

@interface NSString (WebToolkit)

//- (NSString *) md5;
- (NSString*) url_encode;
- (NSString*) url_decode;
- (NSDictionary*) parse_query_string;

@end