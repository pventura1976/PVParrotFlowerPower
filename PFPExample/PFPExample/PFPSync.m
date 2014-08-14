//
//  PFPSync.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPSync.h"
#import "PFPSensor.h"
#import "PFPLocation.h"

@implementation PFPSync

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userConfigVersion": @"user_config_version",
             @"sensors": @"sensors",
             @"errors": NSNull.null, // tell Mantle to ignore this property
             @"serverIdentifier": @"server_identifier",
             @"locations": @"locations"
             };
}

+ (NSValueTransformer *)sensorsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PFPSensor class]];
}

+ (NSValueTransformer *)locationsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PFPLocation class]];
}

@end
