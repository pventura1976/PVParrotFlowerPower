//
//  PFPLocation.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 14/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPLocation : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *plantAssignedDate;
@property (nonatomic) BOOL ignoreMoistureAlert;
@property (nonatomic, strong) NSString *plantNickname;
@property (nonatomic, strong) NSString *locationIdentifier;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic) BOOL inPot;
@property (nonatomic, strong) NSString *sensorSerial;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic) BOOL ignoreTemperatureAlert;
@property (nonatomic) BOOL ignoreFertilizerAlert;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic) BOOL ignoreLightAlert;
@property (nonatomic) BOOL isIndoor;
@property (nonatomic, strong) NSNumber *displayOrder;

@end
