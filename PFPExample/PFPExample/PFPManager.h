//
//  PFPManager.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 16/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa.h>
#import "PFPSensorData.h"
#import "PFPSync.h"

@interface PFPManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong, readonly) PFPSync *currentSyncData;
@property (nonatomic, strong, readonly) PFPSensorData *currentSensorData;

#pragma mark - Authentication

- (void) setParrotFlowerPowerCredentialsWithUserName:(NSString *)userName andPassword:(NSString *)password;

#pragma mark - Sync Data

- (void) fetchSyncData;

#pragma mark - Sensor Data

- (void) fetchSensorDataForLocation:(NSString *)location;
- (void) fetchSensorDataForLocation:(NSString *)location fromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

@end
