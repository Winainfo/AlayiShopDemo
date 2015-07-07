

#import "DetailViewController.h"
#import "CommentTableViewCell.h"
#import "ARLabel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIView *assessView;
@property (weak, nonatomic) IBOutlet ARLabel *goodsNum;
@property (weak, nonatomic) IBOutlet UITextField *goodsNumText;
@property (weak, nonatomic) IBOutlet UITableView *commentTable;
@property (weak, nonatomic) IBOutlet UIView *detailBottomView;
@property (weak, nonatomic) IBOutlet UIButton *evaluateBtn;


@end

@implementation DetailViewController

static BOOL isAssess = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self setNavStyle];
    self.evaluateBtn.backgroundColor = [UIColor whiteColor];
    
    //注册xib
    UINib *nib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]];
    [self.commentTable registerNib:nib forCellReuseIdentifier:@"CommentTableViewCell"];
    
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

#pragma mark 表格代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [self.commentTable dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    if (!cell) {
        cell = [CommentTableViewCell new];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.detailView.backgroundColor = [UIColor lightGrayColor];
    self.assessView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
    isAssess = NO;
    
    
    
}

//添加到购物车
- (IBAction)addCarts:(id)sender {
    int num = [self.goodsNum.text intValue];
    num +=1;
    self.goodsNum.text = [NSString stringWithFormat:@"%d",num];
    self.goodsNumText.text = self.goodsNum.text;
}
- (IBAction)addCartsNum:(id)sender {
    int num = [self.goodsNum.text intValue];
    num +=1;
    self.goodsNum.text = [NSString stringWithFormat:@"%d",num];
    self.goodsNumText.text = self.goodsNum.text;
}

- (IBAction)minusCartsNum:(id)sender {
     int num = [self.goodsNum.text intValue];
    if (num != 0) {
        num -=1;
        self.goodsNum.text = [NSString stringWithFormat:@"%d",num];
        self.goodsNumText.text = self.goodsNum.text;
    }
}
//点击显示详情
- (IBAction)detailClick:(id)sender {
    if (isAssess == YES){
        //改变详情和评价按钮的背景色
        self.detailView.backgroundColor = [UIColor lightGrayColor];
        self.assessView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
        isAssess = NO;
        //显示详情视图
        self.detailBottomView.hidden = NO;
    }
}
//点击显示评价
- (IBAction)assessClick:(id)sender {
    if (isAssess == NO){
        //改变详情和评价按钮的背景色
        self.assessView.backgroundColor = [UIColor lightGrayColor];
        self.detailView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
        isAssess = YES;
        //隐藏详情视图
        self.detailBottomView.hidden = YES;
    }
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
