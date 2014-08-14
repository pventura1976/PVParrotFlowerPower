//
//  PFPManager.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 16/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPManager.h"
#import "PFPConstants.h"
#import "PFPClient.h"
#import "PFPAccessToken.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface PFPManager ()

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) PFPAccessToken *accessToken;
@property (nonatomic, strong, readwrite) PFPSensorData *currentSensorData;
@property (nonatomic, strong, readwrite) PFPSync *currentSyncData;
@property (nonatomic, strong) PFPClient *client;

@end

@implementation PFPManager

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (id)init {
    if (self = [super init]) {
        
        // Initialization

        _client = [PFPClient sharedClientWithId:kClientId andSecret:kClientSecret];
        
    }
    return self;
}

#pragma mark - Authentication

- (void) setParrotFlowerPowerCredentialsWithUserName:(NSString *)userName andPassword:(NSString *)password {
    
    self.userName = userName;
    self.password = password;
    
}

- (RACSignal *)authenticateUserWithUserName:(NSString *)userName andPassword:(NSString *)password {
    
    return [[_client authenticateUser:_userName withPassword:_password] doNext:^(PFPAccessToken *accessToken) {
        
        self.accessToken = accessToken;
        
    }];
    
}

#pragma mark - Sync Data

- (void) fetchSyncData {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Getting Data...", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    [[[[self authenticateUserWithUserName:_userName andPassword:_password]
       flattenMap:^(PFPAccessToken *accessToken) {
        
        return [[[_client getSyncDataWithAccessToken:accessToken.accessToken]
                doNext:^(PFPSync *currentSyncData) {
                    
                    self.currentSyncData = currentSyncData;
                    
                }] doCompleted:^{
                    
                    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Done", nil)];
                    
                }];
        
    }]
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeError:^(NSError *error) {
         
         [SVProgressHUD showErrorWithStatus:error.localizedDescription];
         
     }];
    
}

#pragma mark - Sensor Data

- (void) fetchSensorDataForLocation:(NSString *)location {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Getting Data...", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    [[[[self authenticateUserWithUserName:_userName andPassword:_password]
       flattenMap:^(PFPAccessToken *accessToken) {
           
           return [[[_client getSensorDataForLocation:location withAccessToken:accessToken.accessToken]
                    doNext:^(PFPSensorData *currentSensorData) {
                        
                        self.currentSensorData = currentSensorData;
                        
                    }] doCompleted:^{
                        
                        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Done", nil)];
                        
                    }];
           
       }]
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeError:^(NSError *error) {
         
         [SVProgressHUD showErrorWithStatus:error.localizedDescription];
         
     }];
    
}

- (void) fetchSensorDataForLocation:(NSString *)location fromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Getting Data...", nil) maskType:SVProgressHUDMaskTypeGradient];
    
    [[[[self authenticateUserWithUserName:_userName andPassword:_password]
       flattenMap:^(PFPAccessToken *accessToken) {
           
           return [[[_client getSensorDataForLocation:location fromDate:startDate toDate:endDate withAccessToken:accessToken.accessToken]
                    doNext:^(PFPSensorData *currentSensorData) {
                        
                        self.currentSensorData = currentSensorData;
                        
                    }] doCompleted:^{
                        
                        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Done", nil)];
                        
                    }];
           
       }]
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeError:^(NSError *error) {
         
         [SVProgressHUD showErrorWithStatus:error.localizedDescription];
         
     }];
    
}

@end
