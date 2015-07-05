#import "ShoppingCarController.h"

#define SIZE [UIScreen mainScreen].bounds.size.width

@interface ShoppingCarController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) ShoppingTableViewCell *cell;//单元格属性
@property (strong, nonatomic) ShoppingCartTableViewCell *newcell;
@property (strong, nonatomic) UIButton *editorBut;//移动图片上面的编辑按钮
@property (assign, nonatomic) int count;//数量
@property (strong, nonatomic) UILabel *arrPrice;//总价
@property (strong, nonatomic) NSArray *moveArray;

@property (strong, nonatomic) IBOutlet UILabel *shishi;

@end

@implementation ShoppingCarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%f",SIZE);
    //1.拿到通知中心
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.newcell.cellMoveNum.text];
    
}

#pragma mark - Table view data source


//设置表格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
//设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark ---设置单元格内容


//设置表格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //重用单元格
    static NSString *cellIdentify = @"ShoppingCartTableViewCell";
    static BOOL isReg = NO;
    if (!isReg) {
        UINib *nib = [UINib nibWithNibName:@"ShoppingCartTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentify];
    }
     self.newcell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
//    //设置编辑完成按钮位置
//    self.editorBut = [[UIButton alloc]initWithFrame:CGRectMake(240, 4, 60, 30)];
//    self.editorBut.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_btn_gray"]];
//    [self.editorBut setTitle:@"编辑" forState:UIControlStateNormal];
    
    
    //新的减少按钮
    [self.newcell.cellReduceBut addTarget:self action:@selector(reduceEvent:) forControlEvents:UIControlEventTouchUpInside];
    //新的增加按钮
    [self.newcell.cellAddBut addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];

    [self.newcell.cellOnMoveNum addSubview:self.newcell.cellReduceBut];
    
//    //编辑按钮点击事件
//    [self.editorBut addTarget:self action:@selector(editorBut:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //减少按钮点击事件
//    [self.cell.reduceBut addTarget:self action:@selector(reduceEvent:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //增加按钮点击事件
//    [self.cell.addBut addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
    
//    //删除按钮点击事件
//    [self.cell.removeBut addTarget:self action:@selector(removeBut:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.cell.moveView addSubview:self.editorBut];
    
    self.newcell.cellLabText.text = @"香葱(小葱)/50g[简装]";
    self.newcell.cellMoveNum.text = @"1";//要和增加删除界面的数字相同
    
    self.newcell.cellImage.image = [UIImage imageNamed:@"baicai"];
    
    return self.newcell;
}

//设置表头内容

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *head = [[UIView alloc]init];
//    if (section==0) {
//        head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE, 0)];
//        UIImageView *img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping_cart_body_bg_01"]];
//        [head addSubview:img];
//        
//        
//    }
//    return head;
//}
//设置表头距离
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 15;
//}

//设置表尾内容
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *v = [[UIView alloc]init];
//    UILabel *lab= [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 40, 20)];
//    lab.text = @"总额";
//    lab.font = [UIFont fontWithName:@"Helvetica" size:14.0];
//    
//    self.arrPrice = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 50, 20)];
//    self.arrPrice.font = [UIFont fontWithName:@"Helvetica" size:14.0];
//    self.arrPrice.textColor = [UIColor redColor];
//    self.arrPrice.text = @"0.00";
//    
//    
//    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(180, 10, 100, 40)];
//    //设置按钮背景图片
//    [but setBackgroundImage:[UIImage imageNamed:@"shopping_cart_btn_with_icon"] forState:UIControlStateNormal];
//    //设置按钮标题字体和字体样式
//    [but setTitle:@"结账" forState:UIControlStateNormal];
//    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    //设置按钮字体在按钮内的位置
//    [but titleRectForContentRect:CGRectMake(40, 20, 20, 20)];
//    //设置字体颜色
//    but.tintColor = [UIColor whiteColor];
//    //设置字体距离边框5像素
//    but.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 5);
//    
//    
//    //设置表尾图片
//    if (section==0) {
//        v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE, 0)];
//        UIImageView *i =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping_cart_body_bg_02"]];
//        [v addSubview:i];//添加图片
//        [v addSubview:lab];//添加lab
//        [v addSubview:self.arrPrice];//添加第二个lab
//        [v addSubview:but];//添加按钮
//    }
//    return v;
//    
//    
//    
//}
//
////设置表尾高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}


#pragma  mark ---按钮点击事件


//按钮点击事件
-(void) editorBut :(UIButton *)sender
{
    static BOOL chat = NO;
    if (chat==NO) {
        self.cell.editorConstraint.constant = -SIZE/2.0;
        [self.editorBut setTitle:@"完成" forState:UIControlStateNormal];
        
        chat =YES;
    }else
    {
        self.cell.editorConstraint.constant = 0;
        [self.editorBut setTitle:@"编辑" forState:UIControlStateNormal];
        chat = NO;
    }
    self.cell.moveNum.text = self.cell.editoNumLab.text ;
    float onePirce=[self.cell.UnitPriceLab.text floatValue];
    float numArr=[self.cell.moveNum.text floatValue];
    float sum = 0;
    sum = onePirce * numArr;
    NSString *sumStr=[NSString stringWithFormat:@"%.2f",sum];
    self.arrPrice.text=sumStr;
    
}

//减少按钮事件
- (void) reduceEvent:(UIButton *)sender
{
    self.count =  [self.newcell.cellMoveNum.text intValue];
    if (self.count>0)
    {
        self.count--;
        float onePirce=[self.newcell.cellMoveNum.text floatValue];
        float numArr=[self.newcell.cellPrice.text floatValue];
        float sum = 0;
        sum = onePirce * numArr;
        NSString *sumStr=[NSString stringWithFormat:@"%.2f",sum];
        self.allMoney.text = sumStr;
        
    }
    //将count中转化成字符串类型赋值给shopcount
    self.newcell.cellMoveNum.text=[NSString stringWithFormat:@"%d",self.count];
}

- (void) addEvent:(UIButton *)sender
{
    self.count =  [self.newcell.cellMoveNum.text intValue];
    if (self.count>=0&&self.count<9999)
    {
        self.count++;
        float onePirce=[self.newcell.cellMoveNum.text floatValue];
        float numArr=[self.newcell.cellPrice.text floatValue];
        float sum = 0;
        sum = onePirce * numArr;
        NSString *sumStr=[NSString stringWithFormat:@"%.2f",sum];
        self.allMoney.text = sumStr;
    }
    //将count中转化成字符串类型赋值给shopcount
    self.newcell.cellMoveNum.text=[NSString stringWithFormat:@"%d",self.count];
}

//删除单元格按钮
//-(void) removeBut:(UIButton *)sender
//{
//    [self  delete:self.cell];
//}

//删除单元格
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//
//}
//购物车里面的编辑按钮
- (IBAction)shoppingEditorBut:(id)sender
{
    self.editorView.hidden =!self.editorView.hidden;
}


-(void)textChange
{
    
    float onePirce=[self.newcell.cellMoveNum.text floatValue];
    float numArr=[self.newcell.cellPrice.text floatValue];
    float sum = 0;
    sum = onePirce * numArr;
    NSString *sumStr=[NSString stringWithFormat:@"%.2f",sum];
    self.allMoney.text = sumStr;
    
}
@end
