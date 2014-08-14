//
//  JBChartNoDataView.h
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 16/07/14 (based on Terry Worona's work)
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kJBFontNoDataTitleText [UIFont fontWithName:@"HelveticaNeue" size:20]

@interface JBChartNoDataView : UIView

/*
 * View must be initialized with a layout type (default = horizontal)
 */
- (id)initWithFrame:(CGRect)frame;

// Content
- (void)setTitleText:(NSString *)titleText;

// Color
- (void)setTitleTextColor:(UIColor *)titleTextColor;
- (void)setTextShadowColor:(UIColor *)shadowColor;

// Visibility
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;

@end
