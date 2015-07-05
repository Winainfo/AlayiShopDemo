

#import <UIKit/UIKit.h>

@interface ShoppingTableViewCell : UITableViewCell
/**物品图片*/
@property (strong, nonatomic) IBOutlet UIImageView *foodView;

/**商品名称*/
@property (strong, nonatomic) IBOutlet UILabel *nameLab;

/**商品数量*/
@property (strong, nonatomic) IBOutlet UILabel *moveNum;

/**编辑按钮左边约束*/
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *editorConstraint;

/**编辑按钮第二个约束*/
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *editorConstraintRight;

/**移动图片属性*/
@property (strong, nonatomic) IBOutlet UIView *moveView;

/**编辑VIEW*/
@property (strong, nonatomic) IBOutlet UIView *editorViewRight;

/**在编辑把包含按钮的VIEW*/
@property (strong, nonatomic) IBOutlet UIView *insideView;

/**移除商品按钮*/
@property (strong, nonatomic) IBOutlet UIButton *removeBut;

/**编辑数量lab*/
@property (strong, nonatomic) IBOutlet UILabel *editoNumLab;

/**单价*/
@property (strong, nonatomic) IBOutlet UILabel *UnitPriceLab;
/**减少按钮*/
@property (strong, nonatomic) IBOutlet UIButton *reduceBut;
/**增加按钮*/
@property (strong, nonatomic) IBOutlet UIButton *addBut;

@end
