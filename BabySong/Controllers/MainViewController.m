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
#import "iCarousel.h"
#import "TestViewController.h"

#define CellIdentifier0 @"CellIdentifier0"
#define TBHeaderIdentifier0 @"TBHeaderIdentifier0"

@interface MainViewController ()<SlideViewDelegate,UITableViewDataSource,UITableViewDelegate,iCarouselDelegate,iCarouselDataSource>{
    SlideView *slideView;
}
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong)iCarousel *carouselHeader;
//表头数据源
@property (nonatomic, strong) NSMutableArray *tableHeaderDataArray;
@end

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableHeaderDataArray = [NSMutableArray array];
        for (int i = 0; i < 10; i++)
        {
            [self.tableHeaderDataArray addObject:@(i)];
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    slideView.canPanGestureWork = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addLeftRightButton:@"main_nav_left_btn" highlight:@"main_nav_left_btn"];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.carouselHeader];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier0];
    
    
    slideView = [SlideView setup:self didSelectItem:^(NSInteger index) {
        TestViewController *testVC = [[TestViewController alloc] init];
        [self.navigationController pushViewController:testVC animated:YES];
        slideView.canPanGestureWork = NO;
    }];
    
}

- (void)leftButtonClick:(UIButton *)button{
    [SlideView show];
}

#pragma mark -getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (iCarousel *)carouselHeader{
    if (!_carouselHeader) {
        _carouselHeader = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 372)];
        _carouselHeader.backgroundColor = [UIColor grayColor];
        
        _carouselHeader.delegate = self;
        _carouselHeader.dataSource = self;
        _carouselHeader.type = iCarouselTypeCoverFlow2;
    }
    return _carouselHeader;
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0 forIndexPath:indexPath];
    return cell;
}
#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[self.tableHeaderDataArray count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, carousel.width, carousel.height)];
        view.backgroundColor = [UIColor lightGrayColor];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [self.tableHeaderDataArray[(NSUInteger)index] stringValue];
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel

    
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carouselHeader.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carouselHeader.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.tableHeaderDataArray)[(NSUInteger)index];
    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carouselHeader.currentItemIndex));
}
@end
