//
//  PFPSensorData.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPSensorData : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray *errors;
@property (nonatomic, strong) NSString *serverIdentifier;
@property (nonatomic, strong) NSNumber *userDataVersion;
@property (nonatomic, strong) NSArray *samples; // of PFPSample
@property (nonatomic, strong) NSArray *fertilizers; // of PFPFertilizer
@property (nonatomic, strong) NSArray *events;

@end
