//
//  PFPSync.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPSample.h"

@implementation PFPSample

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"captureTS": @"capture_ts",
             @"vwcPercent": @"vwc_percent",
             @"parUmoleM2s": @"par_umole_m2s",
             @"airTemperatureCelsius": @"air_temperature_celsius",
             @"airTemperatureFahrenheit": @"air_temperature_celsius"
             };
}

+ (NSValueTransformer *)captureTSJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSDate *date = [self.dateFormatter dateFromString:str];
        return date;
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
    
}

+ (NSValueTransformer *)airTemperatureFahrenheitJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        return @((num.floatValue * 9 / 5) + 32);
    } reverseBlock:^(NSNumber *temperature) {
        return @((temperature.floatValue - 32) * 5 / 9);
    }];
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *_formatter;
    
    if (!_formatter) {
        _formatter = [NSDateFormatter new];
        _formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }
    return _formatter;
}

@end
