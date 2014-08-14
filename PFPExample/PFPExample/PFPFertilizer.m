//
//  PFPFertilizer.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPFertilizer.h"
#import "MTLValueTransformer.h"

@implementation PFPFertilizer

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"wateringCycleEndDateTimeUTC": @"watering_cycle_end_date_time_utc",
             @"fertilizerLevel": @"fertilizer_level",
             @"fertilizerId": @"id",
             @"wateringCycleStartDateTimeUTC": @"watering_cycle_start_date_time_utc"
             };
}

+ (NSValueTransformer *)wateringCycleEndDateTimeUTCJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSDate *date = [[self dateFormatter] dateFromString:str];
        return date;
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
    
}

+ (NSValueTransformer *)wateringCycleStartDateTimeUTCJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        NSDate *date = [[self dateFormatter] dateFromString:str];
        return date;
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
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
