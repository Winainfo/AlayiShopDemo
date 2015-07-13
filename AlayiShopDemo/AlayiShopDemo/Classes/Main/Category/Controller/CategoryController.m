//
//  CategoryController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/12.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CategoryController.h"
#import "Category_Cell.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface CategoryController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (retain,nonatomic) NSArray *goodsArray;
@property (assign,nonatomic)BOOL sales_flag;
@property (assign,nonatomic)BOOL price_flag;
@end

@implementation CategoryController
@synthesize type;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",type,@"type",nil];
    [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data)  {
        self.goodsArray=data[@"foodList"];
        NSLog(@"%@",data);
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    //注册Cell
    [self.collectionView registerClass:[Category_Cell class] forCellWithReuseIdentifier:@"Category_Cell"];
}

#pragma mark 实现代理方法
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Category_Cell *cell = (Category_Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Category_Cell" forIndexPath:indexPath];
    cell.goodsNameLabel.text=self.goodsArray[indexPath.row][@"name"];
    cell.goodsPriceLabel.text=self.goodsArray[indexPath.row][@"formatPrice"];
    cell.goodsSaleslabel.text=[NSString stringWithFormat:@"销量:%@笔",self.goodsArray[indexPath.row][@"salenum"]];
    cell.goodsSpecLabel.text=self.goodsArray[indexPath.row][@"norm"];
    //照片
    //拼接图片网址·
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.goodsArray[indexPath.row][@"pic"]];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [cell.goodsImagView sd_setImageWithURL:imgUrl];
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
    if (kScreenWidth==320||kScreenWidth==375) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return UIEdgeInsetsMake(0,0,0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (kScreenWidth==320) {
        return CGSizeMake(150, 140);
    }
    if (kScreenWidth==375) {
        return CGSizeMake(170, 140);
    }
    return CGSizeMake(130, 140);
}

#pragma mark 排序方法
/**
 *  按销量排序
 *
 *  @param sender <#sender description#>
 */
- (IBAction)salesSort:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 100:
        {
            //是否阅读协议
            if (_sales_flag) {
                self.salesImageView.image=[UIImage imageNamed:@"arrow_price_down"];
                //销量降序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"1",@"type",nil];
                [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data)  {
                    self.goodsArray=data[@"foodList"];
                    NSLog(@"%@",data);
                    //调用主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                    });
                }];
                _sales_flag = NO;
            }else{
                self.salesImageView.image=[UIImage imageNamed:@"arrow_price_up"];
                //销量升序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"2",@"type",nil];
                [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data)  {
                    self.goodsArray=data[@"foodList"];
                    NSLog(@"%@",data);
                    //调用主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                    });
                }];

                _sales_flag = YES;
            }
        }
            break;
            
        default:
            break;
    }
}
/**
 *  按价格排序
 *
 *  @param sender <#sender description#>
 */
- (IBAction)priceSort:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 101:
        { 
            if (_price_flag) {
                self.priceImageView.image=[UIImage imageNamed:@"arrow_price_down"];
                //价格降序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"3",@"type",nil];
                [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data)  {
                    self.goodsArray=data[@"foodList"];
                    NSLog(@"%@",data);
                    //调用主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                    });
                }];
                _price_flag = NO;
            }else{
                self.priceImageView.image=[UIImage imageNamed:@"arrow_price_up"];
                //价格升序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"4",@"type",nil];
                [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data)  {
                    self.goodsArray=data[@"foodList"];
                    NSLog(@"%@",data);
                    //调用主线程
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                    });
                }];

                _price_flag = YES;
            }
        }
            break;
            
        default:
            break;
    }

}

@end
