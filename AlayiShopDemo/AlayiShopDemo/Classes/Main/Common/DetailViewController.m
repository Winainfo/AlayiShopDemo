

#import "DetailViewController.h"
#import "CommentTableViewCell.h"
#import "ARLabel.h"
#import "UIImageView+WebCache.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "LoginController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *detailView;//详情的底部视图
@property (weak, nonatomic) IBOutlet UIView *assessView;//评价的底部视图
@property (weak, nonatomic) IBOutlet ARLabel *goodsNum;//底部商品数量
@property (weak, nonatomic) IBOutlet UITextField *goodsNumText;//商品数量
@property (weak, nonatomic) IBOutlet UITableView *commentTable;//评价列表
@property (weak, nonatomic) IBOutlet UIView *detailBottomView;//详情视图
@property (weak, nonatomic) IBOutlet UIButton *evaluateBtn;//评价按钮
/** 详情页具体元素的属性 **/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;//商品图片
@property (weak, nonatomic) IBOutlet ARLabel *goodsName;//商品名称
@property (weak, nonatomic) IBOutlet ARLabel *goodsPrice;//商品价格
@property (weak, nonatomic) IBOutlet ARLabel *goodsSales;//商品销量
@property (weak, nonatomic) IBOutlet ARLabel *goodsNorms;//商品规格
@property (weak, nonatomic) IBOutlet ARLabel *goodsArea;//商品产地
@property (weak, nonatomic) IBOutlet UIImageView *goodsDetailImage;//商品详情图片
@property (weak, nonatomic) IBOutlet UITextView *goodsDescribe;//商品描述
@property (retain,nonatomic) NSString *foodid;//商品ID
@property (retain,nonatomic) NSString *ordnum;//商品订单数





@end

@implementation DetailViewController

static bool inCart = NO;
static BOOL isAssess = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self setNavStyle];
    self.detailView.backgroundColor =  [UIColor colorWithWhite:0.85 alpha:1.000];
    self.title = @"商品详情";
    
    //注册xib
    UINib *nib = [UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]];
    [self.commentTable registerNib:nib forCellReuseIdentifier:@"CommentTableViewCell"];
    
    NSLog(@"字典内容为-------%@",self.detailDic);
    
    NSDictionary *foodDic = self.detailDic[@"food"];
    
    //设置详情页内容
    self.goodsName.text = [NSString stringWithFormat:@"菜名：%@",foodDic[@"name"]];
    self.goodsPrice.text = [NSString stringWithFormat:@"￥：%@",foodDic[@"price"]];
    self.goodsSales.text = [NSString stringWithFormat:@"销量：%@",foodDic[@"salenum"]];
    self.goodsNorms.text = [NSString stringWithFormat:@"规格：%@",foodDic[@"norm"]];
    self.goodsArea.text = [NSString stringWithFormat:@"产地：%@",foodDic[@"pop"]];
    self.goodsDescribe.text = foodDic[@"content"];
    self.foodid = foodDic[@"id"];
    
    /*  请求图片 */
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com/%@",foodDic[@"bigpic"]];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [self.goodsImage sd_setImageWithURL:imgUrl];
   
    NSString *urlStr2 =[NSString stringWithFormat:@"http://www.alayicai.com/%@",foodDic[@"pic"]];
    //转换成url
    NSURL *imgUrl2 = [NSURL URLWithString:urlStr2];
    [self.goodsDetailImage sd_setImageWithURL:imgUrl2];
    
     self.tabBarController.tabBar.hidden = YES;
    
}

//设置导航栏按钮样式
-(void)setNavStyle
{
    //更改导航栏返回按钮图片
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(-5, 5, 50, 50);
    [leftBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=left;
    
    //导航栏右侧按钮
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"sns_more"] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(-5, 5, 30, 30);
    [rightBtn addTarget:self action:@selector(appraiseClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
//放回回上一页
-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}
//跳转到评价页
-(void)appraiseClick
{
    //沙盒路径
    AccountModel *account=[AccountTool account];
    if(account)//已登陆
    {
        //跳出提示框，在提示框中输入评价
        UIAlertView *appraiseAlertV = [[UIAlertView alloc]initWithTitle:@"输入评价" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [appraiseAlertV setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [appraiseAlertV textFieldAtIndex:0];
        [appraiseAlertV show];
        appraiseAlertV.delegate = self;
        appraiseAlertV.tag = 100;
    }else//未登录
    {
       //提示先登录
        UIAlertView *loginAlertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您未登录阿拉亿菜！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [loginAlertV show];
        loginAlertV.delegate = self;
        loginAlertV.tag = 101;
    }
    
}
#pragma mark == AlertView == 代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100)
    {
        if (buttonIndex==1)//提交评论
        {
            //获取评论内容
            UITextField *appraiseTxt = [alertView textFieldAtIndex:0];
            AccountModel *account=[AccountTool account];
            //调用评论接口
            NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",account.name,@"username",@"1",@"type",self.foodid,@"relateid",appraiseTxt.text,@"text", nil];
            [RequestData addFoodComment:param FinishCallbackBlock:^(NSDictionary *data) {
                NSString * code = data[@"code"];
                if ([code isEqualToString:@"0"]) {
                    NSLog( @"评价成功！" );
                }else
                {
                    NSLog(@"评价失败！");
                }
            }];
            
        }
    }else if (alertView.tag == 101)
    {
        if (buttonIndex==1)//跳转到登录页面
        {
            NSLog(@"跳转登录页");
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginController *loginV = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
            [self.navigationController pushViewController:loginV animated:YES];
        }
    }
    
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
    self.detailView.backgroundColor =  [UIColor colorWithWhite:0.85 alpha:1.000];
    self.assessView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
    isAssess = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


//添加到购物车
- (IBAction)addCarts:(id)sender {
    
    int num = [self.goodsNum.text intValue];
    num +=1;
    self.goodsNum.text = [NSString stringWithFormat:@"%d",num];
    self.goodsNumText.text = self.goodsNum.text;
    
    //获取购物车列表
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"32",@"userid", nil];
    [RequestData getUserCartList:param FinishCallbackBlock:^(NSDictionary *data) {
        NSArray *cartListArr = data[@"cartList"];
        NSLog(@"====订单列表：%@",cartListArr);
        for (id obj in cartListArr) {
           NSString *fid = obj[@"foodid"];
            //如果商品ID存在于购物车，则进行更新购物车
            if ([fid isEqualToString:self.foodid]) {
                NSDictionary *param2=[NSDictionary dictionaryWithObjectsAndKeys:self.foodid,@"id",@"32",@"userid",self.goodsNumText.text,@"number",nil];
                [RequestData updateCartNumber:param2 FinishCallbackBlock:^(NSDictionary *data) {
                    NSString *backCode = data[@"code"];
                    if([backCode isEqualToString:@"0"])
                    {
                        NSLog(@"更新成功！");
                        inCart = YES;
                    }else{
                        NSLog(@"更新失败！");
                    }
                }];
            }
        }
         //如果商品ID不存在于购物车，则添加商品到购物车
        if (!inCart) {
            NSDictionary *param3=[NSDictionary dictionaryWithObjectsAndKeys:self.foodid,@"foodid",@"1",@"number",@"32",@"userid",nil];
            [RequestData doAddCart:param3 FinishCallbackBlock:^(NSDictionary *data) {
                NSString *backCode = data[@"code"];
                if([backCode isEqualToString:@"0"])
                {
                    NSLog(@"添加成功！");
                }else{
                    NSLog(@"添加失败！");
                }
            }];
            inCart = YES;
        }
        
    }];
    
}
//加号
- (IBAction)addCartsNum:(id)sender {
    
    int num = [self.goodsNum.text intValue];
    num +=1;
    self.goodsNum.text = [NSString stringWithFormat:@"%d",num];
    self.goodsNumText.text = self.goodsNum.text;
    
    //获取购物车列表
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"32",@"userid", nil];
    [RequestData getUserCartList:param FinishCallbackBlock:^(NSDictionary *data) {
        NSArray *cartListArr = data[@"cartList"];
        NSLog(@"====订单列表：%@",cartListArr);
        for (id obj in cartListArr) {
            NSString *fid = obj[@"foodid"];
            //如果商品ID存在于购物车，则进行更新购物车
            if ([fid isEqualToString:self.foodid]) {
                NSDictionary *param2=[NSDictionary dictionaryWithObjectsAndKeys:self.foodid,@"id",@"32",@"userid",self.goodsNumText.text,@"number",nil];
                [RequestData updateCartNumber:param2 FinishCallbackBlock:^(NSDictionary *data) {
                    NSString *backCode = data[@"code"];
                    if([backCode isEqualToString:@"0"])
                    {
                        NSLog(@"更新成功！");
                        inCart = YES;
                    }else{
                        NSLog(@"更新失败！");
                    }
                }];
            }
        }
        //如果商品ID不存在于购物车，则添加商品到购物车
        if (!inCart) {
            NSDictionary *param3=[NSDictionary dictionaryWithObjectsAndKeys:self.foodid,@"foodid",@"1",@"number",@"32",@"userid",nil];
            [RequestData doAddCart:param3 FinishCallbackBlock:^(NSDictionary *data) {
                NSString *backCode = data[@"code"];
                if([backCode isEqualToString:@"0"])
                {
                    NSLog(@"添加成功！");
                }else{
                    NSLog(@"添加失败！");
                }
            }];
            inCart = YES;
        }
    }];
    
}
//减号
- (IBAction)minusCartsNum:(id)sender {
    
    
    int num = [self.goodsNum.text intValue];
    if (num != 0) {
        num -=1;
        self.goodsNum.text = [NSString stringWithFormat:@"%d",num];
        self.goodsNumText.text = self.goodsNum.text;
    }
    //获取购物车列表
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"32",@"userid", nil];
    [RequestData getUserCartList:param FinishCallbackBlock:^(NSDictionary *data) {
        NSArray *cartListArr = data[@"cartList"];
        NSLog(@"====订单列表：%@",cartListArr);
        for (id obj in cartListArr) {
            NSString *fid = obj[@"foodid"];
            //如果商品ID存在于购物车，则进行删除购物车
            if ([fid isEqualToString:self.foodid]) {
                NSDictionary *param2=[NSDictionary dictionaryWithObjectsAndKeys:self.foodid,@"id",@"32",@"userid",self.goodsNumText.text,@"number",nil];
                [RequestData updateCartNumber:param2 FinishCallbackBlock:^(NSDictionary *data) {
                    NSString *backCode = data[@"code"];
                    if([backCode isEqualToString:@"0"])
                    {
                        NSLog(@"删除成功！");
                    }else{
                        NSLog(@"删除失败！");
                    }
                }];
            }
            //如果商品不存在，则显示提示消息
            if ([self.goodsNumText.text isEqualToString:@"0"]) {
                UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"提示" message:@"商品数量为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertV show];
                inCart = NO;
            }
        }
    }];
  
}
//点击显示详情
- (IBAction)detailClick:(id)sender {
    if (isAssess == YES){
        //改变详情和评价按钮的背景色
        self.detailView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.000];;
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
        self.assessView.backgroundColor =  [UIColor colorWithWhite:0.85 alpha:1.000];;
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


@end
