#import "SortViewController.h"
@interface SortViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *arr;
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    //设置单元格背景颜色
    self.myTableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    //取消单元格线
    self.myTableView.separatorStyle = NO;
    
}

//设置单元格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //标示符
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    //自定义右边箭头
    UIButton *button;
    UIImage *image=[UIImage imageNamed:@"right_arrow_icon"];
    
    button=[UIButton buttonWithType:UIButtonTypeCustom];
    //定义按钮边界是原来按钮大小
    CGRect frame=CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    //按钮的自身边界
    button.frame=frame;
    //设置按钮背景颜色和样式
    [button setBackgroundImage:image forState:UIControlStateNormal];
    //设置按钮颜色，没有颜色
    button.backgroundColor = [UIColor clearColor];
    //让but成为单元格的附加视图
    cell.accessoryView=button;
    //取消Cell选中时背景
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //判断单元格是否重用
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if (indexPath.row==0) {
        UIImageView *TopBg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_top"]];
        cell.backgroundView=TopBg;
    }else if(indexPath.row==8)
    {
        UIImageView *bottomBg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bottom"]];
        cell.backgroundView=bottomBg;
    }else
    {
        UIImageView *midBg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_mid"]];
        cell.backgroundView=midBg;
    }
    cell.textLabel.text = @"新鲜蔬菜";
   
    return cell;
    
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
