//
//  WaterCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/4.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterCell : UITableViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

@end
