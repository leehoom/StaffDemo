//
//  ViewController.m
//  newStaffDemo
//
//  Created by leehoom on 16/3/30.
//  Copyright © 2016年 leehom. All rights reserved.
//

#import "ViewController.h"
#import "RAView.h"
#define MainScreenHeight   [[UIScreen mainScreen] bounds].size.height
#define MainScreenWidth    [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (nonatomic, strong) RAView *staffView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.view.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:244 / 255.0 blue:245 / 255.0 alpha:1];
    
    _staffView = [[RAView alloc] initWithFrame:CGRectMake(50, 200, MainScreenWidth-100, MainScreenHeight)
                                           StaffMode:kRAStaffViewModeHeight];
    [self.view addSubview:_staffView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
