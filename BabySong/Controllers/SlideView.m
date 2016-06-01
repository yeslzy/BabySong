//
//  SlideViewController.m
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import "SlideView.h"
#import "BaseViewController.h"
#import "UIView+Extend.h"
#import "UIView+UIViewUtil.h"
#import "TestViewController.h"

@interface SlideView ()

@property (nonatomic, strong)UIView *mengbanView;

@end

@implementation SlideView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self setup];
        [self test];
        
    }
    return self;
}
- (void)test{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
- (void)buttonClick{
    TestViewController *testVC = [[TestViewController alloc] init];
    [((UIViewController *)self.delegate).navigationController pushViewController:testVC animated:YES];
}
- (void)setup{
    
    [((UIViewController *)self.delegate).view addSubview:self.mengbanView];
    [self.mengbanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mengbanViewTap:)]];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [((UIViewController *)self.delegate).view addGestureRecognizer:pan];
}

#pragma mark -getter
- (UIView *)mengbanView{
    if (!_mengbanView) {
        _mengbanView = [UIView new];
        _mengbanView.alpha = 0.f;
        _mengbanView.hidden = NO;
        _mengbanView.backgroundColor = [UIColor blackColor];
        _mengbanView.frame = [[[UIApplication sharedApplication] windows] objectAtIndex:0].bounds;
    }
    return _mengbanView;
}

- (void)mengbanViewTap:(UITapGestureRecognizer *)tap{
    [self animationHide:YES];
}
- (void)handlePan:(UIPanGestureRecognizer *)ges{
    
    CGPoint point = [ges translationInView:((UIViewController *)self.delegate).view];
    if (ges.state == UIGestureRecognizerStateBegan) {
        self.mengbanView.hidden = NO;
    }
    if (ges.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(self.center.x + point.x, self.center.y);
        if (self.x >= 0) {
            self.x = 0;
        }else if (self.x <= -self.width){
            self.x = -self.width;
        }
        self.mengbanView.alpha = 0.6 * (self.right / self.width);
        [ges setTranslation:CGPointMake(0, 0) inView:((UIViewController *)self.delegate).view];
    }
    if (ges.state == UIGestureRecognizerStateEnded) {
        if (self.x >= 0 || (self.x < 0 && self.x >= -200)) {
            [self animationShow];
        }else if (self.x < -200){
            [self animationHide:YES];
        }
    }
}

- (void)animationShow{
    [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.x = 0;
        self.mengbanView.alpha = 0.6 * (self.right / self.width);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationHide:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.x = -self.width;
            self.mengbanView.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.mengbanView.hidden = YES;
        }];
    }else{
        self.x = -self.width;
        self.mengbanView.alpha = 0.f;
        self.mengbanView.hidden = YES;
    }
    
}
@end
