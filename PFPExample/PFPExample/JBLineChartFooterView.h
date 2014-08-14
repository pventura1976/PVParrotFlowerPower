//
//  JBLineChartFooterView.h
//  JBChartViewDemo
//
//  Created by Terry Worona on 11/8/13.
//  Copyright (c) 2013 Jawbone. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kJBFontFooterLabel [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]
#define kJBFontFooterSubLabel [UIFont fontWithName:@"HelveticaNeue" size:10.0]

@interface JBLineChartFooterView : UIView

@property (nonatomic, strong) UIColor *footerSeparatorColor; // footer separator (default = white)
@property (nonatomic, assign) NSInteger sectionCount; // # of notches (default = 2 on each edge)
@property (nonatomic, readonly) UILabel *leftLabel;
@property (nonatomic, readonly) UILabel *rightLabel;

@end
