//
//  PFPAccessToken.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 13/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Mantle/MTLModel.h>
#import <Mantle/Mantle.h>

@interface PFPAccessToken : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSDate *expiresIn;
@property (nonatomic, strong) NSString *refreshToken;

@end
