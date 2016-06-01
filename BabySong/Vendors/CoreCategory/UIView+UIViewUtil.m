//
//  UIView+UIViewUtil.m
//  G4Manager
//
//  Created by weixia on 15/4/16.
//  Copyright (c) 2015年 cmol. All rights reserved.
//

#import "UIView+UIViewUtil.h"

@implementation UIView (UIViewUtil)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    rect.origin.x = left;
    self.frame = rect;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}


- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}


- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTopLeft:(CGPoint)point
{
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}

- (CGPoint)topLeft
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setBottomRight:(CGPoint)point
{
    CGRect rect = self.frame;
    rect.origin.x = point.x - rect.size.width;
    rect.origin.y = point.y - rect.size.height;
    self.frame = rect;
}

- (CGPoint)bottomRight
{
    return CGPointMake(self.right, self.bottom);
}

- (void)setRightMargin:(CGFloat)rightMargin
{
    self.right = self.superview.bounds.size.width - rightMargin;
}

- (CGFloat)rightMargin
{
    return self.superview.bounds.size.width - self.right;
}

- (void)setBottomMargin:(CGFloat)bottomMargin
{
    self.bottom = self.superview.bounds.size.height - bottomMargin;
}

- (CGFloat)bottomMargin
{
    return self.superview.bounds.size.height - self.bottom;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint p = self.center;
    p.x = centerX;
    self.center = p;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint p = self.center;
    p.y = centerY;
    self.center = p;
}

- (void)moveToCenterOfView:(UIView *)view {
    self.center = [self.superview convertPoint:view.center fromView:view.superview];
}

- (void)moveHorizontalToCenterOfView:(UIView *)view {
    CGFloat x =  [self.superview convertPoint:view.center fromView:view.superview].x;
    self.center = CGPointMake(x, self.center.y);
}

- (void)moveVerticalToCenterOfView:(UIView *)view {
    CGFloat y =  [self.superview convertPoint:view.center fromView:view.superview].y;
    self.center = CGPointMake(self.center.x, y);
}

- (void)moveHorizontalToCenterOfView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect rect = self.frame;
    rect.size.width = view.bounds.size.width - margin * 2;
    self.frame = rect;
    [self moveHorizontalToCenterOfView:view];
}


- (void)moveVerticalToCenterOfView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect rect = self.frame;
    rect.size.height = view.bounds.size.height - margin * 2;
    self.frame = rect;
    [self moveVerticalToCenterOfView:view];
}

- (void)moveToCenter {
    [self moveToCenterOfView:self.superview];
}


- (void)moveHorizontalToCenter {
    [self moveHorizontalToCenterOfView:self.superview];
}


- (void)moveHorizontalToCenterWithMargin:(CGFloat)margin {
    [self moveHorizontalToCenterOfView:self.superview withMargin:margin];
}


- (void)moveVerticalToCenter {
    [self moveVerticalToCenterOfView:self.superview];
}


- (void)moveVerticalToCenterWithMargin:(CGFloat)margin {
    [self moveVerticalToCenterOfView:self.superview withMargin:margin];
}

- (void)moveToCenterOfView:(UIView *)view withMargin:(CGFloat)margin {
    CGPoint centerPoint = [self.superview convertPoint:view.center fromView:view.superview];
    CGFloat width = view.bounds.size.width - margin * 2;
    CGFloat height = view.bounds.size.height - margin * 2;
    CGRect rect;
    rect.origin.x = centerPoint.x - width / 2;
    rect.origin.y = centerPoint.y - height / 2;
    rect.size.width = width;
    rect.size.height = height;
    self.frame = rect;
}

- (void)moveToCenterWithMargin:(CGFloat)margin {
    [self moveToCenterOfView:self.superview withMargin:margin];
}

@end
