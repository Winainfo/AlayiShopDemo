//
//  HWSearchBar.m
//  黑马微博2期
//
//  Created by apple on 14-10-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "LoginBar.h"
#import "UIView+Extension.h"

@implementation LoginBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"  请输入用户名";
        self.background = [UIImage imageNamed:@"common_image_controls"];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"common_btn_addbook"];
        searchIcon.width = 35;
        searchIcon.height = 25;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)loginBar
{
    return [[self alloc] init];
}

@end
