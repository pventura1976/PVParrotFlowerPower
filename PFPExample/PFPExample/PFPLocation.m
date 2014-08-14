//
//  PFPLocation.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPLocation.h"

@implementation PFPLocation

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"plantAssignedDate": @"plant_assigned_date",
             @"ignoreMoistureAlert": @"ignore_moisture_alert",
             @"plantNickname": @"plant_nickname",
             @"locationIdentifier": @"location_identifier",
             @"longitude": @"longitude",
             @"inPot": @"in_pot",
             @"sensorSerial": @"sensor_serial",
             @"images": NSNull.null, // tell Mantle to ignore this property
             @"avatarUrl": @"avatar_url",
             @"ignoreTemperatureAlert": @"ignore_temperature_alert",
             @"ignoreFertilizerAlert": @"ignore_fertilizer_alert",
             @"latitude": @"latitude",
             @"ignoreLightAlert": @"ignore_light_alert",
             @"isIndoor": @"is_indoor",
             @"displayOrder": @"display_order"
             };
}

+ (NSValueTransformer *)ignoreMoistureAlertJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)inPotJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)avatarUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)ignoreTemperatureAlertJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)ignoreFertilizerAlertJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)ignoreLightAlertJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)isIndoorJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

@end
