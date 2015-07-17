//
//  AddressCell.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
//添加代理
@protocol CartCellDelegate <NSObject>
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end
@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ARLabel *receivename;
@property (weak, nonatomic) IBOutlet ARLabel *telephone;
@property (weak, nonatomic) IBOutlet ARLabel *sendaddress;
@property (weak, nonatomic) IBOutlet UIView *isdefaultView;
@property (strong, nonatomic)NSString *isdefault;

@property(assign,nonatomic)id<CartCellDelegate>delegate;
@end
