//
//  BaseAPI.h
//  8a-ios
//
//  Created by Alex Zhang on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIConfig.h"

@interface BaseAPI : NSObject

+(BaseAPI *)shared;

- (void)requestGetWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block;
- (void)requestPostWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block;
- (void)requestDeleteWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block;
- (void)requestPutWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params  withResponse:(void(^)(BOOL success,id res))block;

@end
