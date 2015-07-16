//
//  OrderTableController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderTableController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "SettleController.h"
#import "UIImageView+WebCache.h"
@interface OrderTableController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITableViewCell *AddressCell;
@property (retain,nonatomic)NSArray *goodArray;
@end

@implementation OrderTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *bgColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"address_info_bg"]];
    [self.AddressCell setBackgroundColor:bgColor];
    [self showData];
}
/**显示数据*/
-(void)showData{
    //获取用户购物车的信息
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",nil];
    [RequestData getUserCartList:params FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"%@",data[@"cartList"]);
        self.goodArray=data[@"cartList"];
        self.sumPrice=data[@"sumprice"];
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        if (self.goodArray.count>1) {
            self.ViewA.hidden=NO;
            self.ViewB.hidden=YES;
            for (int i=0; i<self.goodArray.count; i++) {
                //拼接图片网址·
                NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.goodArray[i][@"foodpic"]];
                //转换成url
                NSURL *imgUrl = [NSURL URLWithString:urlStr];
                UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((i*70)+10, 0,60, 60)];
                [imageV sd_setImageWithURL:imgUrl];
                [self.srollView addSubview:imageV];
            }
            
        }else{
            self.ViewA.hidden=YES;
            self.ViewB.hidden=NO;
            //拼接图片网址·
            NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.goodArray[0][@"foodpic"]];
            //转换成url
            NSURL *imgUrl = [NSURL URLWithString:urlStr];
            [self.foodImageView sd_setImageWithURL:imgUrl];
            self.foodNameLabel.text=self.goodArray[0][@"foodname"];
            self.foodPriceLabel.text=self.goodArray[0][@"formatPrice"];
            self.foodNumLabel.text=[NSString stringWithFormat:@"x%@",self.goodArray[0][@"number"]];
            self.countLabel.text=[NSString stringWithFormat:@"共%lu件",self.goodArray.count];
        }
    }];
}

@end
