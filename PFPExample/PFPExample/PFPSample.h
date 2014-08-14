//
//  PFPSample.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPSample : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *captureTS;
@property (nonatomic, strong) NSNumber *vwcPercent; // Volumetric Water Content % -> is a ratio that compares the volume of water in the sample to the total volume of the sample.
@property (nonatomic, strong) NSNumber *parUmoleM2s; // Photosynthetically Active Radiation -> units of micro-mol per metre squared per second (umol/m2/s)
@property (nonatomic, strong) NSNumber *airTemperatureCelsius; // Air Temperature in Celsius
@property (nonatomic, strong) NSNumber *airTemperatureFahrenheit; // Air Temperature in Fahrenheit

@end
