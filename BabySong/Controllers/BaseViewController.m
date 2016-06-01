//
//  BaseViewController.m
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)addLeftRightButton:(NSString *)normol highlight:(NSString *)highlight{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:normol];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)addRightButton:(NSString *)normol highlight:(NSString *)highlight{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:normol];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)rightButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftButtonClick:(UIButton *)button{
    
}

@end
