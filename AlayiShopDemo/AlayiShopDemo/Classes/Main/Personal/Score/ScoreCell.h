//
//  ScoreCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface ScoreCell : UITableViewCell
/**时间*/
@property (weak, nonatomic) IBOutlet ARLabel *timeLabel;
/**积分*/
@property (weak, nonatomic) IBOutlet ARLabel *scoreLabel;
/**积分说明*/
@property (weak, nonatomic) IBOutlet ARLabel *saysLabel;

@end
