//
//  ShoppingCartTableViewCell.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/4.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell<UITextFieldDelegate>
/**单元格里面的图片*/
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;
/**单元格里面标题文字*/
@property (strong, nonatomic) IBOutlet UILabel *cellLabText;
/**单元格里面的价格*/
@property (strong, nonatomic) IBOutlet UILabel *cellPrice;
/**单元格里面的数量*/
@property (strong, nonatomic) IBOutlet UITextField *cellMoveNum;

/**单元格里面的减少按钮*/
@property (strong, nonatomic) IBOutlet UIButton *cellReduceBut;
/**单元格里面的增加按钮*/
@property (strong, nonatomic) IBOutlet UIButton *cellAddBut;
/**单元格里面放修改按钮的view*/
@property (strong, nonatomic) IBOutlet UIView *cellOnMoveNum;
@end
