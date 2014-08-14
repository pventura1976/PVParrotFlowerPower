//
//  PFPAccessToken.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 13/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPAccessToken.h"

@implementation PFPAccessToken

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"accessToken": @"access_token",
             @"expiresIn": @"expires_in",
             @"refreshToken": @"refresh_token"
             };
}

+ (NSValueTransformer *)expiresInJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
    } reverseBlock:^(NSDate *date) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
    
}

@end
