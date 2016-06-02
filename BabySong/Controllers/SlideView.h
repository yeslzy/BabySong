//
//  SlideViewController.h
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideViewDelegate <NSObject>

- (void)didSelectItem:(NSInteger)index;

@end

@interface SlideView : UIView

@property (nonatomic, assign)id<SlideViewDelegate> delegate;

@property (nonatomic, assign)BOOL isShowed;

@property (nonatomic, assign)BOOL canPanGestureWork;

+ (SlideView *)setup:(id)delegate didSelectItem:(void (^)(NSInteger index))selectItemIndex;

+ (void)show;

+ (void)dismiss;

@end


@interface LeftSideCell : UITableViewCell

@end