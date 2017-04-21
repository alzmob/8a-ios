//
//  APIManager.h
//  8a-ios
//
//  Created by Alex Zhang on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPI.h"

@interface APIManager : BaseAPI

+ (APIManager *)shared;

-(void)getConfirmationCodeWithPhoneNumber:(NSString *)number withCompletion:(void(^)(BOOL success,id res))block;

-(void)loginWithPhoneNumber:(NSString *)number confirmationCode: (NSString *)code withCompletion:(void(^)(BOOL success,id res))block;

-(void)loginWithEmail:(NSString *)email password: (NSString *)password withCompletion:(void(^)(BOOL success,id res))block;

@end
