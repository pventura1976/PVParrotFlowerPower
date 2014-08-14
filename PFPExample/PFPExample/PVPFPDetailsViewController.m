//
//  KPPFPDetailsViewController.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 28/07/14.
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "PVPFPDetailsViewController.h"
#import "PFPSensorData.h"
#import "PFPSample.h"
#import "PFPFertilizer.h"
#import "PFPManager.h"
#import "JBLineChartFooterView.h"
#import "JBChartInformationView.h"
#import "JBChartNoDataView.h"
#import <ReactiveCocoa.h>
#import <JBLineChartView.h>

@interface PVPFPDetailsViewController () <JBLineChartViewDataSource, JBLineChartViewDelegate>

@property (nonatomic, strong) JBLineChartView *graph;
@property (nonatomic, strong) JBChartInformationView *informationView;
@property (nonatomic, strong) JBChartNoDataView *noDataView;

@end

@implementation PVPFPDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeGraph];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupObjectsValue];
    
    [self buildGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initializeGraph {
    
    // Chart
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        NSLog(@"iPad");
    }
    else
    {
        NSLog(@"Iphone %f ",[[UIScreen mainScreen] bounds].size.height);
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            NSLog(@"iPhone 5");
            
            [_graphView setFrame:CGRectMake(0, 157, 320, 411)];
        }
        else
        {
            NSLog(@"iPhone 4");
            
            [_graphView setFrame:CGRectMake(0, 157, 320, 323)];
        }
    }
    
    _graph = [[JBLineChartView alloc] initWithFrame:CGRectMake(10, 0, _graphView.frame.size.width - 20, _graphView.frame.size.height / 2)];
    _graph.backgroundColor = [UIColor clearColor];
    _graph.showsLineSelection = YES;
    _graph.showsVerticalSelection = YES;
    _graph.delegate = self;
    _graph.dataSource = self;
    
    // Footer
    JBLineChartFooterView *footerView = [[JBLineChartFooterView alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.footerSeparatorColor = [UIColor blackColor];
    footerView.leftLabel.text = @"";
    footerView.leftLabel.textColor = [UIColor blackColor];
    footerView.rightLabel.text = @"";
    footerView.rightLabel.textColor = [UIColor blackColor];
    footerView.sectionCount = 2;
    _graph.footerView = footerView;
    
    // Information
    _informationView = [[JBChartInformationView alloc] initWithFrame:CGRectMake(10, _graph.frame.origin.y + _graph.frame.size.height, _graphView.frame.size.width - 20, (_graphView.frame.size.height / 2) - 10)];
    [_informationView setValueAndUnitTextColor:[UIColor colorWithRed:156.0f/256 green:202.0f/256 blue:99.0f/256 alpha:1.0]];
    [_informationView setTitleTextColor:[UIColor colorWithRed:156.0f/256 green:202.0f/256 blue:99.0f/256 alpha:1.0]];
    [_informationView setTextShadowColor:nil];
    [_informationView setSeparatorColor:[UIColor blackColor]];
    [_graphView addSubview:_informationView];
    
    // No Data
    _noDataView = [[JBChartNoDataView alloc] initWithFrame:CGRectMake(10, _graph.frame.origin.y + (_graph.frame.size.height / 2) - 20, _graphView.frame.size.width - 20, (_graphView.frame.size.height / 4) - 10)];
    _noDataView.backgroundColor = [UIColor clearColor];
    [_noDataView setTitleText:NSLocalizedString(@"No Data", nil)];
    [_noDataView setTitleTextColor:[UIColor colorWithRed:156.0f/256 green:202.0f/256 blue:99.0f/256 alpha:1.0]];
    [_noDataView setTextShadowColor:nil];
    [_graphView addSubview:_noDataView];
    
    [_graphView addSubview:_graph];
    
}

- (void) setupObjectsValue
{
    self.navigationItem.title = @"PFP Example";
    _selectedSampleType = SampleTypeWater;
    _selectedPeriodType = PeriodType12Hours;
    _locationId = @""; // PFPLocation.locationIdentifier
    _pfpUserName = @""; // User's user name
    _pfpPassword = @""; // User's password
}

#pragma mark - JBLineChartViewDataSource

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView;
{
    return 1;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    NSUInteger value = 0;
    
    switch (_selectedSampleType) {
        case SampleTypeWater:
        case SampleTypeTemperature:
        case SampleTypeLight:
            if (!IsEmpty(_sensorSampleItems))
                value = _sensorSampleItems.count;
            else
                value = 0;
            break;
        case SampleTypeFertilizer:
            if (!IsEmpty(_sensorFertilizerItems))
                value = _sensorFertilizerItems.count;
            else
                value = 0;
            break;
        default:
            break;
    }
    
    return value;
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor colorWithRed:156.0f/256 green:202.0f/256 blue:99.0f/256 alpha:1.0];
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView widthForLineAtLineIndex:(NSUInteger)lineIndex
{
    return 3.0f;
}

- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    float value = 0.0f;
    PFPSample *sample;
    PFPFertilizer *fertilizer;
    
    switch (_selectedSampleType) {
        case SampleTypeWater:
            if ((!IsEmpty(_sensorSampleItems)) && (!IsEmpty([_sensorSampleItems objectAtIndex:horizontalIndex]))) {
                sample = (PFPSample *)[_sensorSampleItems objectAtIndex:horizontalIndex];
                value = [sample.vwcPercent floatValue];
            }
            else
                value = 0;
            break;
        case SampleTypeFertilizer:
            if ((!IsEmpty(_sensorFertilizerItems)) && (!IsEmpty([_sensorFertilizerItems objectAtIndex:horizontalIndex]))) {
                fertilizer = (PFPFertilizer *)[_sensorFertilizerItems objectAtIndex:horizontalIndex];
                value = [fertilizer.fertilizerLevel floatValue];
            }
            else
                value = 0;
            break;
        case SampleTypeTemperature:
            if ((!IsEmpty(_sensorSampleItems)) && (!IsEmpty([_sensorSampleItems objectAtIndex:horizontalIndex]))) {
                sample = (PFPSample *)[_sensorSampleItems objectAtIndex:horizontalIndex];
                value = [sample.airTemperatureCelsius floatValue];
            }
            else
                value = 0;
            break;
        case SampleTypeLight:
            if ((!IsEmpty(_sensorSampleItems)) && (!IsEmpty([_sensorSampleItems objectAtIndex:horizontalIndex]))) {
                sample = (PFPSample *)[_sensorSampleItems objectAtIndex:horizontalIndex];
                value = [sample.parUmoleM2s floatValue];
            }
            else
                value = 0;
            break;
        default:
            break;
    }
    
    return value;
}

- (BOOL)lineChartView:(JBLineChartView *)lineChartView smoothLineAtLineIndex:(NSUInteger)lineIndex
{
    return YES;
}

- (CGFloat)verticalSelectionWidthForLineChartView:(JBLineChartView *)lineChartView {
    return 2.0f;
}

- (UIColor *)verticalSelectionColorForLineChartView:(JBLineChartView *)lineChartView {
    return [UIColor colorWithWhite:0.780 alpha:0.500];
}

#pragma mark - JBLineChartViewDelegate

- (void)lineChartView:(JBLineChartView *)lineChartView didSelectLineAtIndex:(NSUInteger)lineIndex horizontalIndex:(NSUInteger)horizontalIndex touchPoint:(CGPoint)touchPoint
{
    NSNumber *valueNumber;
    NSString *unitText, *titleText;
    
    switch (_selectedSampleType) {
        case SampleTypeWater:
            if ((!IsEmpty(_sensorSampleItems)) && (!IsEmpty([_sensorSampleItems objectAtIndex:horizontalIndex])))
                valueNumber = ((PFPSample *)[_sensorSampleItems objectAtIndex:horizontalIndex]).vwcPercent;
            else
                valueNumber = 0;
            unitText = @"%";
            titleText = NSLocalizedString(@"Volumetric Water Content", nil);
            break;
        case SampleTypeFertilizer:
            if ((!IsEmpty(_sensorFertilizerItems)) && (!IsEmpty([_sensorFertilizerItems objectAtIndex:horizontalIndex])))
                valueNumber = ((PFPFertilizer *)[_sensorFertilizerItems objectAtIndex:horizontalIndex]).fertilizerLevel;
            else
                valueNumber = 0;
            unitText = @"µS/cm";
            titleText = NSLocalizedString(@"Fertilizer Level", nil);
            break;
        case SampleTypeTemperature:
            if ((!IsEmpty(_sensorSampleItems)) && (!IsEmpty([_sensorSampleItems objectAtIndex:horizontalIndex]))) {
             
                PFPSample *theSample = [_sensorSampleItems objectAtIndex:horizontalIndex];
                valueNumber = theSample.airTemperatureCelsius;
                
            }
            else
                valueNumber = 0;
            unitText = @"℃";
            titleText = NSLocalizedString(@"Air Temperature", nil);
            break;
        case SampleTypeLight:
            if ((!IsEmpty(_sensorSampleItems)) && (!IsEmpty([_sensorSampleItems objectAtIndex:horizontalIndex])))
                valueNumber = ((PFPSample *)[_sensorSampleItems objectAtIndex:horizontalIndex]).parUmoleM2s;
            else
                valueNumber = 0;
            unitText = @"µmol/m^2/s";
            titleText = NSLocalizedString(@"Photosynthetically Active Radiation", nil);
            break;
        default:
            break;
    }
    
    [self.informationView setValueText:[NSString stringWithFormat:@"%.2f", [valueNumber floatValue]] unitText:unitText];
    [self.informationView setTitleText:titleText];
    [self.informationView setHidden:NO animated:YES];
}

- (void)didDeselectLineInLineChartView:(JBLineChartView *)lineChartView
{
    [self.informationView setHidden:YES animated:YES];
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView selectionColorForLineAtLineIndex:(NSUInteger)lineIndex
{
    return [UIColor colorWithRed:0.435 green:0.563 blue:0.281 alpha:1.000];
}

#pragma mark - Graph

- (void) buildGraph {
    
    [[[RACObserve([PFPManager sharedManager], currentSensorData) ignore:nil]
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(PFPSensorData *currentSensorData) {
         
         // Samples and Fertilizer items come with no specific order.
         // Currently Parrot Web API has a bug and returns all fertilizer samples: https://flowerpowerdev.parrot.com/boards/1/topics/23
         _sensorSampleItems = [self filterAndOrderSamples:currentSensorData.samples betweenStartDate:_selectedStartDate andEndDate:_selectedEndDate];
         _sensorFertilizerItems = [self filterAndOrderFertilizers:currentSensorData.fertilizers betweenStartDate:_selectedStartDate andEndDate:_selectedEndDate];
         
         ((JBLineChartFooterView *)_graph.footerView).leftLabel.text = [NSString stringWithFormat:@"%@", _selectedStartDate];
         
         ((JBLineChartFooterView *)_graph.footerView).rightLabel.text = [NSString stringWithFormat:@"%@", _selectedEndDate];
         
         [self reloadGraph];
         
     }];
    
    NSInteger seconds;
    
    _selectedEndDate = [NSDate date];
    
    seconds = [self secondsInPeriod:_selectedPeriodType];
    _selectedStartDate = [NSDate dateWithTimeInterval:(-1 * seconds) sinceDate:_selectedEndDate];
    
    _graph.userInteractionEnabled = NO;
    [self.noDataView setHidden:NO animated:YES];
    [[PFPManager sharedManager] setParrotFlowerPowerCredentialsWithUserName:_pfpUserName andPassword:_pfpPassword];
    [[PFPManager sharedManager] fetchSensorDataForLocation:_locationId fromDate:_selectedStartDate toDate:_selectedEndDate];
    
}

- (NSArray *) filterAndOrderSamples:(NSArray*)samples betweenStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate {
    
    NSArray *sortedArray = [samples sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(PFPSample *)a captureTS];
        NSDate *second = [(PFPSample *)b captureTS];
        return [first compare:second];
    }];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"captureTS >= %@ AND captureTS <= %@", startDate, endDate];
    
    return [sortedArray filteredArrayUsingPredicate:predicate] ;
    
}

- (NSArray *) filterAndOrderFertilizers:(NSArray*)fertilizers betweenStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate {
    
    NSArray *sortedArray = [fertilizers sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(PFPFertilizer *)a wateringCycleStartDateTimeUTC];
        NSDate *second = [(PFPFertilizer *)b wateringCycleStartDateTimeUTC];
        return [first compare:second];
    }];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"wateringCycleStartDateTimeUTC >= %@ AND wateringCycleStartDateTimeUTC <= %@", startDate, endDate];
    
    return [sortedArray filteredArrayUsingPredicate:predicate] ;
    
}

- (void) reloadGraph {
    
    switch (_selectedSampleType) {
        case SampleTypeWater:
        case SampleTypeLight:
        case SampleTypeTemperature:
            if (!IsEmpty(_sensorSampleItems)) {
                _graph.userInteractionEnabled = YES;
                [self.noDataView setHidden:YES animated:YES];
            }
            else {
                _graph.userInteractionEnabled = NO;
                [self.noDataView setHidden:NO animated:YES];
            }
            break;
        case SampleTypeFertilizer:
            if (!IsEmpty(_sensorFertilizerItems)) {
                _graph.userInteractionEnabled = YES;
                [self.noDataView setHidden:YES animated:YES];
            }
            else {
                _graph.userInteractionEnabled = NO;
                [self.noDataView setHidden:NO animated:YES];
            }
            break;
            
        default:
            break;
    }
    
    [_graph reloadData];
    
}

- (NSInteger)secondsInPeriod:(PeriodType)periodType {
    NSInteger seconds;
    seconds = 60 * 60; // (minutes * seconds) in 1 hour
    switch (periodType) {
        case PeriodType12Hours:
            seconds *= 12;
            break;
        case PeriodType24Hours:
            seconds *= 24;
            break;
        case PeriodType3Days:
            seconds *= 3 * 24;
            break;
        case PeriodType7Days:
            seconds *= 7 * 24;
            break;
        case PeriodType14Days:
            seconds *= 14 * 24;
            break;
        default:
            break;
    }
    return seconds;
}

#pragma mark - Segmented Buttons

- (IBAction)sampleTypeChanged:(id)sender {
    
    UISegmentedControl *button = (UISegmentedControl *)sender;
    _selectedSampleType = button.selectedSegmentIndex;
    
    [self reloadGraph];
    
}

- (IBAction)periodTypeChanged:(id)sender {
    
    UISegmentedControl *button = (UISegmentedControl *)sender;
    _selectedPeriodType = button.selectedSegmentIndex;
    
    NSInteger seconds;
    
    _selectedEndDate = [NSDate date];
    
    seconds = [self secondsInPeriod:_selectedPeriodType];
    _selectedStartDate = [NSDate dateWithTimeInterval:(-1 * seconds) sinceDate:_selectedEndDate];
    
    _graph.userInteractionEnabled = NO;
    [[PFPManager sharedManager] fetchSensorDataForLocation:_locationId fromDate:_selectedStartDate toDate:_selectedEndDate];
    
}

@end
