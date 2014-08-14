//
//  JBChartNoDataView.m
//  PFPExample
//
//  Created by Pedro Ramón Ventura Gómez on 16/07/14 (based on Terry Worona's work)
//  Copyright (c) 2014 Pedro Ramón Ventura Gómez. All rights reserved.
//

#import "JBChartNoDataView.h"

// Numerics

CGFloat const kJBChartNoDataViewPadding = 10.0f;
CGFloat const kJBChartNoDataViewTitleHeight = 50.0f;
CGFloat const kJBChartNoDataViewTitleWidth = 75.0f;
CGFloat const kJBChartNoDataViewDefaultAnimationDuration = 0.25f;

// Colors (JBChartNoDataView)
static UIColor *kJBChartNoDataViewTitleColor = nil;
static UIColor *kJBChartNoDataViewShadowColor = nil;

@interface JBChartNoDataView ()

@property (nonatomic, strong) UILabel *titleLabel;

// Position
- (CGRect)titleViewRectForHidden:(BOOL)hidden;

@end

@implementation JBChartNoDataView

#pragma mark - Alloc/Init

+ (void)initialize
{
	if (self == [JBChartNoDataView class])
	{
        kJBChartNoDataViewTitleColor = [UIColor blackColor];
        kJBChartNoDataViewShadowColor = [UIColor blackColor];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kJBFontNoDataTitleText;
        _titleLabel.numberOfLines = 1;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kJBChartNoDataViewTitleColor;
        _titleLabel.shadowColor = kJBChartNoDataViewShadowColor;
        _titleLabel.shadowOffset = CGSizeMake(0, 1);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        [self setHidden:YES animated:NO];
    }
    return self;
}

#pragma mark - Position

- (CGRect)titleViewRectForHidden:(BOOL)hidden
{
    CGRect titleRect = CGRectZero;
    
    titleRect.origin.x = kJBChartNoDataViewPadding;
    titleRect.origin.y = hidden ? -kJBChartNoDataViewTitleHeight : kJBChartNoDataViewPadding;
    titleRect.size.width = self.bounds.size.width - (kJBChartNoDataViewPadding * 2);
    titleRect.size.height = kJBChartNoDataViewTitleHeight;
    
    return titleRect;
}

#pragma mark - Setters

- (void)setTitleText:(NSString *)titleText
{
    self.titleLabel.text = titleText;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    self.titleLabel.textColor = titleTextColor;
}

- (void)setTextShadowColor:(UIColor *)shadowColor
{
    self.titleLabel.shadowColor = shadowColor;
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (animated)
    {
        if (hidden)
        {
            [UIView animateWithDuration:kJBChartNoDataViewDefaultAnimationDuration * 0.5 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                self.titleLabel.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                
                self.titleLabel.frame = [self titleViewRectForHidden:YES];
                
            }];
        }
        else
        {
            [UIView animateWithDuration:kJBChartNoDataViewDefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                
                self.titleLabel.frame = [self titleViewRectForHidden:NO];
                self.titleLabel.alpha = 1.0;
                
            } completion:nil];
        }
    }
    else
    {
        self.titleLabel.frame = [self titleViewRectForHidden:hidden];
        self.titleLabel.alpha = hidden ? 0.0 : 1.0;
    }
}

- (void)setHidden:(BOOL)hidden
{
    [self setHidden:hidden animated:NO];
}

@end
