//
//  PFPClient.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 13/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa.h>

@interface PFPClient : NSObject

#pragma mark - Initialization

+ (instancetype)sharedClient;

+ (instancetype)sharedClientWithId:(NSString *)clientId andSecret:(NSString *)clientSecret;

#pragma mark - App Identification

@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSString *clientSecret;

#pragma mark - Authentication

- (RACSignal *)authenticateUser:(NSString *)userName withPassword:(NSString *)password;

#pragma mark - Sync

- (RACSignal *)getSyncDataWithAccessToken:(NSString *)accessToken;

#pragma mark - Sensor Data

- (RACSignal *)getSensorDataForLocation:(NSString*)locationId withAccessToken:(NSString *)accessToken;

- (RACSignal *)getSensorDataForLocation:(NSString*)locationId fromDate:(NSDate*)startDate toDate:(NSDate*)endDate withAccessToken:(NSString *)accessToken;

@end
