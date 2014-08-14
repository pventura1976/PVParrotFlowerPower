//
//  PFPSync.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPSync : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *userConfigVersion;
@property (nonatomic, strong) NSArray *sensors; // of PFPSensor
@property (nonatomic, strong) NSArray *errors;
@property (nonatomic, strong) NSString *serverIdentifier;
@property (nonatomic, strong) NSArray *locations; // of PFPLocation

@end
