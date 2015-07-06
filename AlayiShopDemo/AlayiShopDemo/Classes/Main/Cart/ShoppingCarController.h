

#import <UIKit/UIKit.h>
#import "ShoppingTableViewCell.h"
#import "ShoppingCartTableViewCell.h"


@interface ShoppingCarController : UIViewController
/**编辑按钮改变的图片*/
@property (strong, nonatomic) IBOutlet UIView *editorView;
/**总金额*/
@property (strong, nonatomic) IBOutlet UITextField *allMoney;
/**购物车编辑按钮属性*/
@property (strong, nonatomic) IBOutlet UIButton *spcEditor;

@end
