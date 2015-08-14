//
//  EditFoodController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/15.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditFoodController : UIViewController
/**添加/修改标识:0.添加、1.修改*/
@property (retain,nonatomic)NSString *flag;
/**自制菜id*/
@property (retain,nonatomic)NSString *foodId;
/**菜名*/
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/**描述*/
@property (weak, nonatomic) IBOutlet UITextView *describeText;
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@end
