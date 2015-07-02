//
//  FinallyViewController.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SequenceCollectionViewCell.h"
#import "AppDelegate.h"

#define SIZE [UIScreen mainScreen].bounds.size.width

@interface FinallyViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *cellView;

@end
