//
//  SelfFoodController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/15.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "SelfFoodController.h"
#import "SelfFoodCollectionViewCell.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "EditFoodController.h"
//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface SelfFoodController ()<SelfFoodDelegate>
@property(retain,nonatomic)NSArray *goodsArray;
@end

@implementation SelfFoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册Cell
    [self.collectionView registerClass:[SelfFoodCollectionViewCell class] forCellWithReuseIdentifier:@"SelfFoodCollectionViewCell"];
    AccountModel *account=[AccountTool account];
     NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",account.userId,@"userid", nil];
    [RequestData getUserSelfFoodWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        self.goodsArray=data[@"selfFoodList"];
        NSLog(@"%@",self.goodsArray);
        //更新主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
}

#pragma mark 实现代理方法
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelfFoodCollectionViewCell *cell = (SelfFoodCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelfFoodCollectionViewCell" forIndexPath:indexPath];
    cell.foodTitle.text=self.goodsArray[indexPath.row][@"title"];
    cell.foodId=self.goodsArray[indexPath.row][@"id"];
    //照片
    //拼接图片网址
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.goodsArray[indexPath.row][@"pic"]];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [cell.foodImage sd_setImageWithURL:imgUrl];
    cell.delegate=self;
    return cell;
}

#pragma mark 实现UICollectionViewDelegateFlowLayout代理
/**
 *  定义每个UICollectionView的间距
 *
 *  @param collectionView       <#collectionView description#>
 *  @param collectionViewLayout <#collectionViewLayout description#>
 *  @param section              <#section description#>
 *
 *  @return <#return value description#>
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);
}
/**
 *定义每个UICollectionView的大小
 *
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (kScreenWidth==320) {
        return CGSizeMake(140, 170);
    }
    if (kScreenWidth==375) {
        return CGSizeMake(170, 170);
    }
    return CGSizeMake(120, 170);
}

#pragma mark -- 实现删除编辑点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识，11 为减按钮，12为加按钮
 */
-(void)btnClick:(UICollectionViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.collectionView indexPathForCell:cell];
     NSString *gid=self.goodsArray[index.row][@"id"];
    switch (flag) {
        case 11:
        {
            //设置故事板为第一启动
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"wjl" bundle:nil];
            EditFoodController *edit=[storyboard instantiateViewControllerWithIdentifier:@"添加自制菜View"];
            edit.foodId=gid;
            edit.flag=@"1";
            [self.navigationController pushViewController:edit animated:YES];
        }
            break;
        case 12:
        {
           
             NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:gid,@"id", nil];
            [RequestData delSelfFood:params FinishCallbackBlock:^(NSDictionary *data) {
                NSLog(@"删除成功");
            }];
            AccountModel *account=[AccountTool account];
            NSDictionary *params1=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",account.userId,@"userid", nil];
            [RequestData getUserSelfFoodWithPage:params1 FinishCallbackBlock:^(NSDictionary *data) {
                self.goodsArray=data[@"selfFoodList"];
                NSLog(@"%@",self.goodsArray);
                //更新主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
            }];
        }
            break;
        default:
            break;
    }
  
}

@end
