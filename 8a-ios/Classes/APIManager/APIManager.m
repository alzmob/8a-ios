//
//  APIManager.m
//  8a-ios
//
//  Created by Alex Zhang on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (APIManager *)shared
{
    static APIManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIManager alloc] init];
    });
    
    return sharedInstance;
    
}

-(void)getConfirmationCodeWithPhoneNumber:(NSString *)number withCompletion:(void(^)(BOOL success,id res))block{
    
    [self requestPostWithURL: BASE_URL atPath: RequestConfirmationCode withParams: @{@"phoneNumber": number } withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

-(void)loginWithPhoneNumber:(NSString *)number confirmationCode: (NSString *)code withCompletion:(void(^)(BOOL success,id res))block{
    
    [self requestPostWithURL: BASE_URL atPath: LoginWithCredentials withParams: @{@"phoneNumber": number, @"confirmationCode": code} withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

-(void)loginWithEmail:(NSString *)email password: (NSString *)password withCompletion:(void(^)(BOOL success,id res))block {
    
    [self requestPostWithURL: BASE_URL atPath: RequestConfirmationCode withParams: @{@"email": email, @"password": password} withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

-(void)getProfile:(NSString *)auth withCompletion:(void(^)(BOOL success,id res))block {
    
    [self requestGetWithURL:BASE_URL atPath:RequestProfile withAuth:auth withParams:nil withResponse:^(BOOL success, id res) {
        if (success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:res options:0 error:nil];
            block(success, dict);
        }
        else {
            block(success, res);
        }
    }];
}

@end
