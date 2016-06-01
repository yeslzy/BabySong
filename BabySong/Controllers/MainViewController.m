//
//  MainViewController.m
//  MusicApp
//
//  Created by nsobject on 16/6/1.
//  Copyright © 2016年 nsobject. All rights reserved.
//

#import "MainViewController.h"
#import "SlideView.h"
#import "UIView+Extend.h"

@interface MainViewController ()<SlideViewDelegate,UIGestureRecognizerDelegate>{
    SlideView *slideView;
}
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation MainViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    
    slideView = [[SlideView alloc] initWithFrame:CGRectMake(-VIEW_WIDTH/3.0*2, 0, VIEW_WIDTH/3.0*2, VIEW_HEIGHT) delegate:self];
    slideView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:slideView];
    
    
}


#pragma mark -getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}
@end
