//
//  FinanceApi.h
//  Mobile Finance
//
//  Created by Taimoor Ali on 3/25/14.
//  Copyright (c) 2013 Taimoor Ali. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinanceApi : NSObject 

+ (id) get:(NSString *) call params:(NSMutableDictionary *) params;
//+ (void) get: (NSString *) call params:(NSMutableDictionary *) params responseHandler:(void (^)(id data))handler;

//+ (id) post:(NSString *) call params:(NSMutableDictionary *) params images:(NSMutableDictionary *) images;
+ (void) post:(NSString *) call params:(NSMutableDictionary *) params images:(NSMutableDictionary *) images responseHandler:(void (^)(id data))handler;

+ (id) getURLString:(NSString *) call params:(NSMutableDictionary *) params;
//+ (UITableViewCell *) getLoadingCell: (UITableView *)tableView;


+ (NSDictionary *) post:(NSString *) call params:(NSMutableDictionary *) params ;
+ (NSDictionary *) get: (NSString *) call params:(NSMutableDictionary *) params responseHandler:(void (^)(id data))handler;
+ (NSURLRequest *) getRequest:(NSString *) call method:(NSString *)method params:(NSMutableDictionary *) params;

@end
