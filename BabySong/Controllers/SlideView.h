//
//  SlideViewController.h
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideViewDelegate <NSObject>



@end

@interface SlideView : UIView

@property (nonatomic, assign)id<SlideViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
