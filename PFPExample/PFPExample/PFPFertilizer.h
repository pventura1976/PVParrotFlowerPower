//
//  PFPFertilizer.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPFertilizer : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *wateringCycleEndDateTimeUTC;
@property (nonatomic, strong) NSNumber *fertilizerLevel; // µS/cm
@property (nonatomic, strong) NSNumber *fertilizerId;
@property (nonatomic, strong) NSDate *wateringCycleStartDateTimeUTC;

@end
