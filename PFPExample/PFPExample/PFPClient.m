//
//  PFPClient.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 13/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPClient.h"
#import "PFPAccessToken.h"
#import "PFPSync.h"
#import "PFPSensorData.h"

@interface PFPClient ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation PFPClient

#pragma mark - Class Initialization

+ (instancetype)sharedClient {
    static id _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}

+ (instancetype)sharedClientWithId:(NSString *)clientId andSecret:(NSString *)clientSecret {
    
    PFPClient *client = [PFPClient sharedClient];
    
    client.clientId = clientId;
    client.clientSecret = clientSecret;
    
    return client;
}

#pragma mark - Instance Initialization

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

#pragma mark - Authentication

- (RACSignal *)authenticateUser:(NSString *)userName withPassword:(NSString *)password {
    
    NSString *urlString = [NSString stringWithFormat:@"https://apiflowerpower.parrot.com/user/v1/authenticate?grant_type=password&username=%@&password=%@&client_id=%@&client_secret=%@", userName, password, _clientId, _clientSecret];
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[PFPAccessToken class] fromJSONDictionary:json error:nil];
    }];
    
}

#pragma mark - Sync

- (RACSignal *)getSyncDataWithAccessToken:(NSString *)accessToken {
    
    NSString *urlString = [NSString stringWithFormat:@"https://apiflowerpower.parrot.com/sensor_data/v3/sync"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *headers = @{
                              @"Authorization" : [NSString stringWithFormat:@"Bearer %@", accessToken]
                              };
    
    return [[self fetchJSONFromURL:url withHeaders:headers] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[PFPSync class] fromJSONDictionary:json error:nil];
    }];
    
}

#pragma mark - Sensor Data

- (RACSignal *)getSensorDataForLocation:(NSString*)locationId withAccessToken:(NSString *)accessToken {
    
    NSString *urlString = [NSString stringWithFormat:@"https://apiflowerpower.parrot.com/sensor_data/v2/sample/location/%@", locationId];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *headers = @{
                              @"Authorization" : [NSString stringWithFormat:@"Bearer %@", accessToken]
                              };
    
    return [[self fetchJSONFromURL:url withHeaders:headers] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[PFPSensorData class] fromJSONDictionary:json error:nil];
    }];
    
}

- (RACSignal *)getSensorDataForLocation:(NSString*)locationId fromDate:(NSDate*)startDate toDate:(NSDate*)endDate withAccessToken:(NSString *)accessToken {
    
    NSString *urlString = [NSString stringWithFormat:@"https://apiflowerpower.parrot.com/sensor_data/v2/sample/location/%@?from_datetime_utc=%@&to_datetime_utc=%@", locationId, [[self dateFormatter] stringFromDate:startDate], [[self dateFormatter] stringFromDate:endDate]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *headers = @{
                              @"Authorization" : [NSString stringWithFormat:@"Bearer %@", accessToken]
                              };
    
    return [[self fetchJSONFromURL:url withHeaders:headers] map:^(NSDictionary *json) {
        return [MTLJSONAdapter modelOfClass:[PFPSensorData class] fromJSONDictionary:json error:nil];
    }];
    
}

#pragma mark - Utilities

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
    NSLog(@"Fetching: %@", url.absoluteString);
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (! jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
            
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
        
    }] doError:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url withHeaders:(NSDictionary *)headers {
    NSLog(@"Fetching: %@", url.absoluteString);
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                               timeoutInterval:60.0];
        [urlRequest setHTTPMethod:@"GET"];
        
        for (NSString *key in headers.allKeys) {
            [urlRequest addValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
        
        NSURLSessionDataTask * dataTask = [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (! jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
            
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
        
    }] doError:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}

- (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *_formatter;
    
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }
    return _formatter;
}

@end
