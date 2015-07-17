//
//  TableViewController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/8.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
#import "RequestData.h"
@interface TableViewController : UITableViewController
/**新鲜菜品*/
//新鲜菜品1
@property (weak, nonatomic) IBOutlet ARLabel *freshNameLabel1;
@property (weak, nonatomic) IBOutlet ARLabel *freshPriceLabel1;
@property (weak, nonatomic) IBOutlet ARLabel *freshSpecLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *freshGoodsImage1;
//新鲜菜品2
@property (weak, nonatomic) IBOutlet ARLabel *freshNameLabel2;
@property (weak, nonatomic) IBOutlet ARLabel *freshPriceLabel2;
@property (weak, nonatomic) IBOutlet ARLabel *freshSpecLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *freshGoodsImage2;
//新鲜菜品3
@property (weak, nonatomic) IBOutlet ARLabel *freshNameLabel3;
@property (weak, nonatomic) IBOutlet ARLabel *freshPriceLabel3;
@property (weak, nonatomic) IBOutlet ARLabel *freshSpecLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *freshGoodsImage3;
//新鲜菜品4
@property (weak, nonatomic) IBOutlet ARLabel *freshNameLabel4;
@property (weak, nonatomic) IBOutlet UIImageView *freshGoodsImage4;
//新鲜菜品5
@property (weak, nonatomic) IBOutlet ARLabel *freshNameLabel5;
@property (weak, nonatomic) IBOutlet UIImageView *freshGoodsImage5;
//新鲜菜品6
@property (weak, nonatomic) IBOutlet ARLabel *freshNameLabel6;
@property (weak, nonatomic) IBOutlet UIImageView *freshGoodsImage6;
/**最新推荐*/
//推荐菜品1
@property (weak, nonatomic) IBOutlet ARLabel *recomNameLabel1;
@property (weak, nonatomic) IBOutlet ARLabel *recomPriceLabel1;
@property (weak, nonatomic) IBOutlet ARLabel *recomSpecLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *recomGoodsImage1;
//推荐菜品2
@property (weak, nonatomic) IBOutlet ARLabel *recomNameLabel2;
@property (weak, nonatomic) IBOutlet ARLabel *recomPriceLabel2;
@property (weak, nonatomic) IBOutlet ARLabel *recomSpecLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *recomGoodsImage2;
//推荐菜品3
@property (weak, nonatomic) IBOutlet ARLabel *recomNameLabel3;
@property (weak, nonatomic) IBOutlet ARLabel *recomPriceLabel3;
@property (weak, nonatomic) IBOutlet ARLabel *recomSpecLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *recomGoodsImage3;
//推荐菜品4
@property (weak, nonatomic) IBOutlet ARLabel *recomNameLabel4;
@property (weak, nonatomic) IBOutlet UIImageView *recomGoodsImage4;
//推荐菜品5
@property (weak, nonatomic) IBOutlet ARLabel *recomNameLabel5;
@property (weak, nonatomic) IBOutlet UIImageView *recomGoodsImage5;
//推荐菜品6
@property (weak, nonatomic) IBOutlet ARLabel *recomNameLabel6;
@property (weak, nonatomic) IBOutlet UIImageView *recomGoodsImage6;

/**会员自制*/
//自制菜品1
@property (weak, nonatomic) IBOutlet ARLabel *memberNameLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *memberGoodsImage1;
//自制菜品2
@property (weak, nonatomic) IBOutlet ARLabel *memberNameLabel2;
@property (weak, nonatomic) IBOutlet UIImageView *memberGoodsImage2;
//自制菜品3
@property (weak, nonatomic) IBOutlet ARLabel *memberNameLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *memberGoodsImage3;
//自制菜品4
@property (weak, nonatomic) IBOutlet ARLabel *memberNameLabel4;
@property (weak, nonatomic) IBOutlet UIImageView *memberGoodsImage4;
//自制菜品5
@property (weak, nonatomic) IBOutlet ARLabel *memberNameLabel5;
@property (weak, nonatomic) IBOutlet UIImageView *memberGoodsImage5;
//自制菜品6
@property (weak, nonatomic) IBOutlet ARLabel *memberNameLabel6;
@property (weak, nonatomic) IBOutlet UIImageView *memberGoodsImage6;
@end
