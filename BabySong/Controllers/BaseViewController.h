//
//  BaseViewController.h
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)addLeftRightButton:(NSString *)normol highlight:(NSString *)highlight;

- (void)addRightButton:(NSString *)normol highlight:(NSString *)highlight;

- (void)rightButtonClick:(UIButton *)button;

- (void)leftButtonClick:(UIButton *)button;

@end
