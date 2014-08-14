//
//  PFPSensor.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPSensor : MTLModel <MTLJSONSerializing>

typedef NS_ENUM(NSUInteger, SensorColor) {
    SensorColorBrown = 4,
    SensorColorGreen = 6,
    SensorColorBlue = 7
};

@property (nonatomic, strong) NSString *sensorSerial;
@property (nonatomic, strong) NSNumber *color;
@property (nonatomic, strong) NSString *firmwareVersion;
@property (nonatomic, strong) NSString *nickname;

@end
