//
//  BaseNavigationController.m
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+Color.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *navBackImage = [UIImage imageFromContextWithColor:rgb(252, 70, 30)];
    
    [self.navigationBar setBackgroundImage:navBackImage forBarMetrics:UIBarMetricsDefault];
}




@end
