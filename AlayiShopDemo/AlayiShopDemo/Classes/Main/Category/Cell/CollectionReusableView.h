//
//  CollectionReusableView.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/13.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface CollectionReusableView : UICollectionReusableView
/**标题*/
@property (weak, nonatomic) IBOutlet ARLabel *titleLabel;

@end
