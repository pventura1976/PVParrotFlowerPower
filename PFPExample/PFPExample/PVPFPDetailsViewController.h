//
//  KPPFPDetailsViewController.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 28/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SampleType) {
    SampleTypeWater,
    SampleTypeFertilizer,
    SampleTypeTemperature,
    SampleTypeLight
};

typedef NS_ENUM(NSUInteger, PeriodType) {
    PeriodType12Hours,
    PeriodType24Hours,
    PeriodType3Days,
    PeriodType7Days,
    PeriodType14Days
};

static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

@interface PVPFPDetailsViewController : UIViewController

@property (strong, nonatomic) NSString *locationId; // Location identifier from PFPLocation.locationIdentifier
@property (strong, nonatomic) NSString *pfpUserName; // User's user name
@property (strong, nonatomic) NSString *pfpPassword; // User's password

@property (strong, nonatomic) NSArray *sensorSampleItems;
@property (strong, nonatomic) NSArray *sensorFertilizerItems;

@property (nonatomic) SampleType selectedSampleType;
@property (nonatomic) PeriodType selectedPeriodType;
@property (strong, nonatomic) NSDate *selectedStartDate;
@property (strong, nonatomic) NSDate *selectedEndDate;

@property (strong, nonatomic) NSArray *waterItems;
@property (strong, nonatomic) NSArray *fertilizerItems;
@property (strong, nonatomic) NSArray *temperatureItems;
@property (strong, nonatomic) NSArray *lightItems;

@property (weak, nonatomic) IBOutlet UISegmentedControl *pfpDataTypeOptions;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pfpTimeIntervalOptions;
@property (weak, nonatomic) IBOutlet UIView *graphView;

@end
