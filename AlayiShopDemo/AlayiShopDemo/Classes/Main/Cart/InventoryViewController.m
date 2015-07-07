

#import "InventoryViewController.h"
#define HIZI [UIScreen mainScreen].bounds.size.height
#define SIZI [UIScreen mainScreen].bounds.size.width


@interface InventoryViewController ()
//含有账号的视图
@property (strong, nonatomic) IBOutlet UIView *zhanghao;
//商品介绍
@property (strong, nonatomic) IBOutlet UIView *shangpinjiesao;
//留言界面
@property (strong, nonatomic) IBOutlet UIView *liuyan;

//支付配送
@property (strong, nonatomic) IBOutlet UIView *zhifupeisong;

//总金额页面
@property (strong, nonatomic) IBOutlet UIView *zongjine;


//scorview约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *yueshu;

@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.yueshu.constant = HIZI;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ontView
{
    
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
