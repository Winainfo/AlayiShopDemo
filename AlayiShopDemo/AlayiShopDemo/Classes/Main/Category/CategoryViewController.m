//
//  CategoryViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CategoryViewController.h"
#import "Category_Cell.h"
//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface CategoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.CollectionView registerClass:[Category_Cell class] forCellWithReuseIdentifier:@"Category_Cell"];
}
#pragma mark 实现代理方法
//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Category_Cell *cell = (Category_Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Category_Cell" forIndexPath:indexPath];
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
    if (kScreenWidth==320||kScreenWidth==375) {
        return CGSizeMake(150, 140);
    }
    return CGSizeMake(130, 140);
}
@end
