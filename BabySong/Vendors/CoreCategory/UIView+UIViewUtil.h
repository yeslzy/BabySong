//
//  UIView+UIViewUtil.h
//  G4Manager
//
//  Created by weixia on 15/4/16.
//  Copyright (c) 2015年 cmol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewUtil)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

// 视图右边在 superview 中的位置
@property (nonatomic) CGFloat right;

// 视图底边在 superview 中的位置
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;



@property (nonatomic) CGPoint topLeft;

@property (nonatomic) CGSize size;

@property (nonatomic) CGPoint bottomRight;

// 视图右边与 superview 的右边的距离
@property (nonatomic) CGFloat rightMargin;

// 视图底边与 superview 的底边的距离
@property (nonatomic) CGFloat bottomMargin;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;


- (void)moveToCenterOfView:(UIView *)view;
- (void)moveToCenterOfView:(UIView *)view withMargin:(CGFloat)margin;

- (void)moveToCenter;
- (void)moveToCenterWithMargin:(CGFloat)margin;

- (void)moveHorizontalToCenterOfView:(UIView *)view;
- (void)moveHorizontalToCenter;

- (void)moveHorizontalToCenterOfView:(UIView *)view withMargin:(CGFloat)margin;
- (void)moveHorizontalToCenterWithMargin:(CGFloat)margin;

- (void)moveVerticalToCenterOfView:(UIView *)view;
- (void)moveVerticalToCenter;

- (void)moveVerticalToCenterOfView:(UIView *)view withMargin:(CGFloat)margin;
- (void)moveVerticalToCenterWithMargin:(CGFloat)margin;

@end
