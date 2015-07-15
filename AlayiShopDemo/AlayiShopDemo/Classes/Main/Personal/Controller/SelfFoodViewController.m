
#import "SelfFoodViewController.h"
#import "SelfFoodCollectionViewCell.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
#import "API.h"
#import "MJRefresh.h"
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface SelfFoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(retain,nonatomic)UICollectionView *selfFoodV;//九宫格视图
@property(retain,nonatomic)NSMutableArray *selfFoodListArr;//所有自制菜的数组
//@property(retain,nonatomic)NSMutableArray *titleArr;
//@property(retain,nonatomic)NSMutableArray *picUrlArr;
//@property(retain,nonatomic)NSMutableArray *picArr;
@property(retain,nonatomic)NSArray *goodsArray;

@end

@implementation SelfFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavStyle];
    
    //为数组申请空间
//    self.selfFoodListArr = [NSMutableArray arrayWithCapacity:1];
//    self.titleArr = [NSMutableArray arrayWithCapacity:1];
//    self.picUrlArr = [NSMutableArray arrayWithCapacity:1];
//    self.picArr = [NSMutableArray arrayWithCapacity:1];
    
    //创建展示自制菜的九宫格
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.selfFoodV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-94) collectionViewLayout:layout];
    self.selfFoodV.delegate = self;
    _selfFoodV.dataSource = self;
    _selfFoodV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selfFoodV];
    _selfFoodV.showsVerticalScrollIndicator = NO;
    //注册自定义的cell类
    UINib *nib = [UINib nibWithNibName:@"SelfFoodCollectionViewCell" bundle:[NSBundle mainBundle]];
    [_selfFoodV registerNib:nib forCellWithReuseIdentifier:@"SelfFoodCollectionViewCell"];
    
    //调用接口请求数据
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"1",@"userid", nil];
    [RequestData getUserSelfFoodWithPage:prama FinishCallbackBlock:^(NSDictionary *data) {
        self.goodsArray=data[@"selfFoodList"];
        NSLog(@"%@",self.goodsArray);
    }];
 
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

#pragma mark -- collectionView 代理 --
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // return self.goodsArray.count;
  return 10;
}
////定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//    
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelfFoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelfFoodCollectionViewCell" forIndexPath:indexPath];

    //设置自制菜的图片
   // [cell.foodImage sd_setImageWithURL:self.picUrlArr[indexPath.row]];
    //设置自制菜菜名
    cell.foodTitle.text = @"asdas";
    return cell;
}
//设置单元格尺寸的代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int width = WIDTH;
    int height = HEIGHT;
    if (width == 320) {
        if (height == 480) {
            return CGSizeMake(120, 170);
        }
        return  CGSizeMake(145, 205);
    }
    if (width == 375) {
         return  CGSizeMake(111, 158);
    }else
    {
     return  CGSizeMake(124, 176);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    int width = WIDTH;
    if (width == 320) {
        return UIEdgeInsetsMake(10 , 10, 20, 10);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//单元格左间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//单元格行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 35;
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
