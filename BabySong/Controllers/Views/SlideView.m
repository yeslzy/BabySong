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
#import "UIFont+Extend.h"

@interface SlideView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIView *mengbanView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)void (^selectItem)(NSInteger index);

@property (nonatomic, strong)NSArray *itemArray;

@end
static SlideView *slideView = nil;
@implementation SlideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemArray = @[@"首页",@"正在播放"];
    }
    return self;
}

+ (SlideView *)setup:(id)delegate
       didSelectItem:(void (^)(NSInteger index))selectItemIndex{
    if (!slideView) {
        slideView = [[SlideView alloc] initWithFrame:CGRectMake(-VIEW_WIDTH/3.0*2, 0, VIEW_WIDTH/3.0*2, VIEW_HEIGHT)];
        slideView.backgroundColor = View_Background_Color;
        slideView.selectItem = selectItemIndex;
        slideView.isShowed = NO;
        slideView.canPanGestureWork = YES;
        slideView.backgroundColor = [UIColor greenColor];
        slideView.delegate = delegate;
        [slideView setup];
        [slideView addSubview:slideView.tableView];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:slideView];
    }
    return slideView;
}

+ (void)show{
    [slideView animationShow];
    
}

+ (void)dismiss{
    [slideView animationHide:YES duration:.2f];
    
}

- (void)setup{
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self.mengbanView];
    [self.mengbanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mengbanViewTap:)]];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addGestureRecognizer:pan];
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
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = View_Background_Color;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 20)];
        _tableView.tableHeaderView.backgroundColor = View_Background_Color;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    }
    return _tableView;
}
#pragma mark -event
- (void)mengbanViewTap:(UITapGestureRecognizer *)tap{
    [self animationHide:YES duration:0.2];
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
            [self animationHide:YES duration:0.2];
        }
    }
}
#pragma mark -animation
- (void)animationShow{
    self.mengbanView.hidden = NO;
    [UIView animateWithDuration:.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.x = 0;
        self.mengbanView.alpha = 0.6 * (self.right / self.width);
    } completion:^(BOOL finished) {
        self.isShowed = YES;
    }];
}

- (void)animationHide:(BOOL)animated duration:(NSTimeInterval)time{
    if (animated) {
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.x = -self.width;
            self.mengbanView.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.mengbanView.hidden = YES;
        }];
    }else{
        self.x = -self.width;
        self.mengbanView.alpha = 0.f;
        self.mengbanView.hidden = YES;
        self.isShowed = YES;
    }
    
}
#pragma mark -UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.canPanGestureWork;
}
#pragma mark -
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.itemArray[indexPath.row];
    cell.textLabel.font = [UIFont songTypefaceFontOfSize:14];
    return cell;
}
#pragma mark -
#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self animationHide:YES duration:0.1];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectItem(indexPath.row);
}
@end


@implementation LeftSideCell


@end
