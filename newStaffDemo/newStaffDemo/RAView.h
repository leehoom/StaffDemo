//
//  RAView.h
//  Staff_Demo
//
//  Created by leehoom on 16/3/29.
//  Copyright © 2016年 leehom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kRAStaffViewMode) {
    kRAStaffViewModeWeight = 1300,
    kRAStaffViewModeHeight = 110,
    kRAStaffViewModeAge = 104
};

@interface RAView : UIView

@property (nonatomic, assign) kRAStaffViewMode mode;

- (id)initWithFrame:(CGRect)frame StaffMode:(kRAStaffViewMode) mode;


@end
