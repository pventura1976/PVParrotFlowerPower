//
//  PFPSensorData.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPSensorData.h"
#import "PFPSample.h"
#import "PFPFertilizer.h"

@implementation PFPSensorData

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"errors": NSNull.null, // tell Mantle to ignore this property
             @"serverIdentifier": @"server_identifier",
             @"userDataVersion": @"user_data_version",
             @"samples": @"samples",
             @"fertilizers": @"fertilizer",
             @"events": NSNull.null // tell Mantle to ignore this property
             };
}

+ (NSValueTransformer *)samplesJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PFPSample class]];
}

+ (NSValueTransformer *)fertilizersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[PFPFertilizer class]];
}

@end
