//
//  CategoryController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/12.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CategoryController.h"

//自定义搜索栏的头
#import "HWSearchBar.h"
//UIView 的类目，可直接设置frame,size...
#import "UIView+Extension.h"

#import "DetailViewController.h"
#import "Category_Cell.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface CategoryController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain,nonatomic) HWSearchBar *mySearchBar;//搜索栏
@end

@implementation CategoryController
@synthesize type;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavStyle];
    
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
    
    //为导航栏视图添加搜索栏
    _mySearchBar = [HWSearchBar searchBar];
    _mySearchBar.width = 300;
    _mySearchBar.height = 30;
    self.navigationItem.titleView = _mySearchBar;
    //设置搜索栏的代理
    _mySearchBar.delegate=self;
    
     self.tabBarController.tabBar.hidden = YES;
}

//隐藏和显示底部标签栏
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

//设置导航栏按钮样式
-(void)setNavStyle
{
    //更改导航栏返回按钮图片
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(-5, 5, 30, 30);
    [leftBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=left;
}
//放回回上一页
-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
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
    cell.goodsID = (int)self.goodsArray[indexPath.row][@"id"];
    //照片
    //拼接图片网址
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.goodsArray[indexPath.row][@"pic"]];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [cell.goodsImagView sd_setImageWithURL:imgUrl];
    return cell;
}
//点击图片，跳到详情页
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *gID = self.goodsArray[indexPath.row][@"id"];
    NSDictionary *params2=[NSDictionary dictionaryWithObjectsAndKeys:gID,@"id", nil];
    [RequestData getFoodById:params2 FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
         NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
        
    }];
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
    //如果type=5有值，则为推荐菜
    if (type&&(type.intValue!=0)) {
        type = @"0";
        switch (btn.tag) {
            case 100:
            {
                //是否阅读协议
                if (_sales_flag) {
                    self.salesImageView.image=[UIImage imageNamed:@"arrow_price_down"];
                    //销量降序
                    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"5",@"type",nil];
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
                    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"5",@"type",nil];
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
    else{//type没有值，则为所有菜或者搜索菜名结果
        
    switch (btn.tag) {
        case 100:
        {
            //是否阅读协议
            if (_sales_flag) {
                self.salesImageView.image=[UIImage imageNamed:@"arrow_price_down"];
                //nsstring转换为UTF-8
                NSString *name =[self.searchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //销量降序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",name,@"name",@"1",@"type",nil];
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
                //nsstring转换为UTF-8
                NSString *name =[self.searchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //销量升序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",name,@"name",@"2",@"type",nil];
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
}
/**
 *  按价格排序
 *
 *  @param sender <#sender description#>
 */
- (IBAction)priceSort:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    //如果type=5有值，则为推荐菜
    if (type&&(type.intValue!=0)) {
       type = @"0";
        switch (btn.tag) {
            case 100:
            {
                //是否阅读协议
                if (_sales_flag) {
                    self.salesImageView.image=[UIImage imageNamed:@"arrow_price_down"];
                    //销量降序
                    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"5",@"type",nil];
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
                    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"5",@"type",nil];
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
     else{//type没有值或者type=0，则为所有菜或者搜索菜名结果
    
    switch (btn.tag) {
        case 101:
        { 
            if (_price_flag) {
                self.priceImageView.image=[UIImage imageNamed:@"arrow_price_down"];
                //nsstring转换为UTF-8
                NSString *name =[self.searchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //价格降序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",name,@"name",@"3",@"type",nil];
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
                //nsstring转换为UTF-8
                NSString *name =[self.searchName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //价格升序
                NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",name,@"name",@"4",@"type",nil];
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
}

#pragma mark 文本框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    //点击RETURN键即开始搜索，跳转到搜索结果页
    NSString *searchTxt =[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //通过历史搜索进行查找商品
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",searchTxt,@"name",@"",@"type", nil];
    [RequestData getFoodListWithPage:param FinishCallbackBlock:^(NSDictionary * data) {
        
        NSArray *foodListArr = data[@"foodList"];
        NSLog(@"搜索结果 == %@",foodListArr);
        //为搜索结果赋值
        self.goodsArray = foodListArr;
        self.searchName = textField.text;
        [self.collectionView reloadData];
    }];
    //搜索完成清空输入框的文字
    textField.text = nil;
    [textField resignFirstResponder];//收起键盘
    return YES;
}

@end
