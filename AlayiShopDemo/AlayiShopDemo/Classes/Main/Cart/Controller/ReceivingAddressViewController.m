#import "ReceivingAddressViewController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "AddressCell.h"
#import "AddressTableController.h"
#import "OrderTool.h"
#import "SettleController.h"
@interface ReceivingAddressViewController ()<UITableViewDataSource,UITableViewDelegate,CartCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *addresstableView;
@property (strong ,nonatomic)NSMutableArray *addressArray;
@end

@implementation ReceivingAddressViewController
//隐藏和显示底部标签栏
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收货地址";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    
    // Do any additional setup after loading the view.
    self.addressArray = [NSMutableArray arrayWithCapacity:1];
    [self getAllUserSendAddressByUserid];//网络请求数据
    //创建XIB文件
    UINib *nib=[UINib nibWithNibName:@"AddressCell" bundle:[NSBundle mainBundle]];
    //注册到表格视图
    [self.addresstableView registerNib:nib forCellReuseIdentifier:@"AddressCell"];
    self.addresstableView.tableFooterView = [[UIView alloc] init];;
}

/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- 用户所有的送货地址信息
- (void)getAllUserSendAddressByUserid{
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",nil];
    [RequestData getAllUserSendAddressByUserid:params FinishCallbackBlock:^(NSDictionary *data) {
        if ([data[@"code"] isEqualToString:@"0"]) {
            [self.addressArray addObjectsFromArray:data[@"userSendAddresslist"]];
            [self.addresstableView reloadData];
        }
    }];
}

#pragma mark ---表格设置
//表格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
//表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}
//定制表格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"AddressCell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.receivename.text = self.addressArray[indexPath.row][@"receivename"];
    cell.telephone.text = self.addressArray[indexPath.row][@"telephone"];
    cell.sendaddress.text = self.addressArray[indexPath.row][@"sendaddress"];
    cell.isdefault = self.addressArray[indexPath.row][@"isdefault"];
    if ([cell.isdefault isEqualToString:@"1"]) {
        cell.isdefaultView.hidden = NO;
        cell.sendaddress.hidden = YES;
    }else{
        cell.isdefaultView.hidden = YES;
        cell.sendaddress.hidden = NO;
    }
    //取消Cell选中时背景
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    return cell;
}
/**
 *  点击事件
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OrderModel *order=[OrderModel new];
//    order.telephone=self.addressArray[indexPath.row][@"telephone"];
//    order.sendaddress=self.addressArray[indexPath.row][@"sendaddress"];
//    order.receivename=self.addressArray[indexPath.row][@"receivename"];
//    [OrderTool saveOrder:order];
    //指定跳转
    for(UIViewController *controller in self.navigationController.viewControllers) {
        if([controller isKindOfClass:[SettleController class]]){
            SettleController *settle=(SettleController *)controller;
            settle.addressId=self.addressArray[indexPath.row][@"id"];
            [self.navigationController popToViewController:settle animated:YES];
        }
    }
}



//单元格编辑状态
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //删除用户送货地址信息
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.addressArray[indexPath.row][@"id"],@"id",nil];
        [RequestData delUserSendAddress:params FinishCallbackBlock:^(NSDictionary *data) {
            if ([data[@"code"] isEqualToString:@"0"]) {
                [self.addressArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
}


- (IBAction)addClick:(UIButton *)sender {
    //设置故事板为第一启动
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddressTableController *address=[storyboard instantiateViewControllerWithIdentifier:@"添加地址View"];
    address.flag=@"0";
    [self.navigationController pushViewController:address animated:YES];
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识
 */
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [_addresstableView indexPathForCell:cell];
    switch (flag) {
        case 200:
        {
            //设置故事板为第一启动
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            AddressTableController *address=[storyboard instantiateViewControllerWithIdentifier:@"添加地址View"];
            address.flag=@"1";
            address.f_id=self.addressArray[index.row][@"id"];
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        default:
            break;
    }

    
}

@end
