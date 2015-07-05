//
//  SelfFoodViewController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "SelfFoodViewController.h"
#import "SelfFoodCollectionViewCell.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface SelfFoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation SelfFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *selfFoodV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-94) collectionViewLayout:layout];
    selfFoodV.delegate = self;
    selfFoodV.dataSource = self;
    selfFoodV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selfFoodV];
    selfFoodV.showsVerticalScrollIndicator = NO;
    //注册自定义的cell类
    UINib *nib = [UINib nibWithNibName:@"SelfFoodCollectionViewCell" bundle:[NSBundle mainBundle]];
    [selfFoodV registerNib:nib forCellWithReuseIdentifier:@"SelfFoodCollectionViewCell"];
 
}

#pragma mark -- collectionView 代理 --
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelfFoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelfFoodCollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//设置单元格尺寸的代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int width = WIDTH;
    if (width == 320) {
         return  CGSizeMake(145, 205);
    }
    if (width == 375) {
         return  CGSizeMake(111, 158);
    }else
    {
     return  CGSizeMake(124, 176);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
