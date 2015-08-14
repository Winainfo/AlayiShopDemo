//
//  SelfFoodController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/15.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfFoodController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
