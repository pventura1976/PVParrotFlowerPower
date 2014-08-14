//
//  PFPSensor.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PFPSensor.h"

@implementation PFPSensor

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"sensorSerial": @"sensor_serial",
             @"color": @"color",
             @"firmwareVersion": @"firmware_version",
             @"nickname": @"nickname"
             };
}

@end
