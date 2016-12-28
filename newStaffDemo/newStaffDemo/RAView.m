//
//  RAView.m
//  Staff_Demo
//
//  Created by leehoom on 16/3/29.
//  Copyright © 2016年 leehom. All rights reserved.
//

#import "RAView.h"

#define MainScreenHeight   [[UIScreen mainScreen] bounds].size.height
#define MainScreenWidth    [[UIScreen mainScreen] bounds].size.width

@interface RAView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *staffScroll;
@property (nonatomic, strong) CALayer *staffLayer;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIView *windowView;
@property (nonatomic, strong) UILabel *currentNum;

@end

@implementation RAView

- (id)initWithFrame:(CGRect)frame StaffMode:(kRAStaffViewMode)mode
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _mode = mode;
        self.staffScroll = [[UIScrollView alloc] init];
        self.staffScroll.frame = CGRectMake(0, 0, MainScreenWidth-100, 100);
        self.staffScroll.delegate = self;
        self.staffScroll.alpha = 1;
        self.staffScroll.contentSize = CGSizeMake(mode*10+MainScreenWidth-100, 0);//13000+275
        if (_mode == kRAStaffViewModeWeight) {
            self.staffScroll.contentOffset = CGPointMake(5500, 0);
        } else if (_mode == kRAStaffViewModeHeight) {
            self.staffScroll.contentOffset = CGPointMake(500, 0);
        } else if (_mode == kRAStaffViewModeAge){
            self.staffScroll.contentOffset = CGPointMake(800, 0);
        }
        self.staffScroll.showsHorizontalScrollIndicator = NO;
        self.staffScroll.pagingEnabled = NO;
        self.staffScroll.bounces = NO;
        
        self.currentNum = [[UILabel alloc] init];
        self.currentNum.center = CGPointMake(MainScreenWidth/2-50, 100);
        self.currentNum.bounds = CGRectMake(0, 0, 100, 100);
        self.currentNum.text = @"80";
        self.currentNum.font = [UIFont systemFontOfSize:20];
        self.currentNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.currentNum];
        
        [self layoutStaffNumView];
        [self addSubview:_staffScroll];
        [self layoutWindowView];
        UILabel *oneLabel = [[UILabel alloc] init];
        oneLabel.frame = CGRectMake(MainScreenWidth/2-1-50, 0, 2, 10);
        oneLabel.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:80 / 255.0 blue:39 / 255.0 alpha:1];
        [self addSubview:oneLabel];
        [self layoutCurrentNumView];
    }
    return self;
}

#pragma mark -- layout
//过渡纱窗效果
- (void)layoutWindowView
{
    int num = (MainScreenWidth/2-50)/5;
    for (int i = 0; i <= 2*num; i++) {
        self.windowView = [[UIView alloc] init];
        if (i > num) {
            self.windowView.frame = CGRectMake(MainScreenWidth/2-5-1-((i-num)*5)-50, 0, 5, 40);
            self.windowView.alpha = 0.05*(i-num);
        } else {
            self.windowView.frame = CGRectMake(MainScreenWidth/2+1+i*5-50, 0, 5, 40);
            self.windowView.alpha = 0.05*i;
        }
        self.windowView.backgroundColor = [UIColor whiteColor];
        self.windowView.userInteractionEnabled = NO;
        [self addSubview:self.windowView];
    }
}

//当前刻度
- (void)layoutCurrentNumView
{
    
}

//标尺刻度
- (void)layoutStaffNumView
{
    for (int i = 0 ; i <= _mode; i++) {
        self.staffLayer = [CALayer layer];
        self.staffLayer.backgroundColor = [UIColor grayColor].CGColor;
        [self.staffScroll.layer addSublayer:self.staffLayer];
        if (i%10 == 0) {
            self.staffLayer.frame = CGRectMake(MainScreenWidth/2-50+10*i, 0, 1, 10);
            self.numLabel = [[UILabel alloc] init];
            self.numLabel.center = CGPointMake(MainScreenWidth/2-50+10*i, 25);
            self.numLabel.bounds = CGRectMake(0, 0, 50, 20);
            if (_mode == kRAStaffViewModeWeight) {
                self.numLabel.text = [NSString stringWithFormat:@"%d", i/10+20];
            } else if (_mode == kRAStaffViewModeHeight) {
                self.numLabel.text = [NSString stringWithFormat:@"%d", i+120];
            } else if (_mode == kRAStaffViewModeAge){
                self.numLabel.text = [NSString stringWithFormat:@"%d", i+1910];
            }
            self.numLabel.font = [UIFont fontWithName:@"DIN-Medium" size:13];
            self.numLabel.textAlignment = NSTextAlignmentCenter;
            [self.staffScroll addSubview:self.numLabel];
        } else {
            self.staffLayer.frame = CGRectMake(MainScreenWidth/2-50+10*i, 0, 1, 5);
        }
    }
}

#pragma mark -- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int num = scrollView.contentOffset.x;
    _currentNum.text = [NSString stringWithFormat:@"%d", num/10+120];
    
    NSLog(@"%f", scrollView.contentOffset.x);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    [self scrollViewReboundAnimation:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewReboundAnimation:scrollView];
}

#pragma mark -- action
- (void)scrollViewReboundAnimation:(UIScrollView *)scrollView
{
    int currentX = scrollView.contentOffset.x;
    int remainder = currentX % 10000 % 1000 % 100 % 10;
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    if (remainder < 5) {
        int theX = currentX - remainder;
        self.staffScroll.contentOffset = CGPointMake(theX, 0);
    } else {
        int theX = currentX+10 - remainder;
        self.staffScroll.contentOffset = CGPointMake(theX, 0);
    }
    [UIView commitAnimations];
}

@end
