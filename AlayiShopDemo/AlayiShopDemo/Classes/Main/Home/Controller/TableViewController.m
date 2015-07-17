//
//  TableViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/8.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "TableViewController.h"
#import "UIImageView+WebCache.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
@interface TableViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (retain,nonatomic) NSArray *imageArray;
@property (retain,nonatomic) NSArray *freshArray;
@property (retain,nonatomic) NSArray *recomArray;
@property (retain,nonatomic) NSArray *memberArray;
@property (weak, nonatomic) IBOutlet UIView *freshGoodsView;

@end
//获得当前屏幕宽高点数（非像素）
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉表格线
    self.tableView.separatorStyle=NO;
    //代理
    self.myScrollView.delegate=self;
    //页面控制的当前页
    self.myPageControl.currentPage = 0;
    //滚动视图
    [self scrollViewAdv];
    //最新菜品
    [self freshGoodsData];
    //最新推荐
    [self recomGoodsData];
    //自制菜
    //[self memberGoodsData];
    
    [self setNavStyle];
    
}

//设置导航栏按钮样式
-(void)setNavStyle
{
    //标题
    self.title = @"阿拉亿菜";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //导航栏右侧按钮
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(-5, 5, 30, 30);
    [rightBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
//跳转到搜索页
-(void)searchClick
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *searchV = [storyboard instantiateViewControllerWithIdentifier:@"searchView"];
    [self.navigationController pushViewController:searchV animated:YES];
}

#pragma mark 滚动视图
/**
 *  请求数据
 */
-(void)scrollViewAdv
{
    //获取首页广告图片数组
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys: nil];
    [RequestData getAllHotFoodList:prama FinishCallbackBlock:^(NSDictionary * data) {
        self.imageArray=data[@"hotFoodList"];
        //设置滚动视图的包含的视图大小和图片
        [self scrollViewWithFrame:self.myScrollView.frame andImages:self.imageArray];
        //设置定时滚动
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollAdView) userInfo:nil repeats:YES];
    }];

}

-(void)scrollViewWithFrame:(CGRect)frame andImages:(NSArray *)images
{
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.pagingEnabled = YES;
    //不显示边框外视图
    self.myScrollView.bounces= NO;
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width*images.count, self.myScrollView.frame.size.height);
    self.myPageControl.numberOfPages = images.count;
    //为滚动视图添加图片
    for (int i=0; i<images.count; i++) {
        //拼接图片网址·
        NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",images[i][@"pic"]];
        //转换成url
        NSURL *imgUrl = [NSURL URLWithString:urlStr];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
        [imageV sd_setImageWithURL:imgUrl];
        [self.myScrollView addSubview:imageV];
    }
}

//定时器自动滚动广告
- (void)scrollAdView
{
    int currentNum=(self.myScrollView.contentOffset.x/self.myScrollView.frame.size.width+1);
    if (currentNum == 5) {
        currentNum = 0;
    }
    self.myScrollView.contentOffset=CGPointMake(self.myScrollView.frame.size.width*currentNum,0);
    self.myPageControl.currentPage = currentNum;
    
}

#pragma mark 手动拖动的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/self.myScrollView.frame.size.width;
    self.myPageControl.currentPage=page;
}
#pragma mark table代理
/**
 *  设置rowHeight
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 130;
    }
    if (kScreenWidth==320||kScreenWidth==375) {
        return 334;
    }
    else if(kScreenWidth==414)
    {
        return 424;
    }
    return 334;
}
#pragma mark----数据请求
/**
 *  新鲜菜品数据请求
 */
-(void)freshGoodsData
{
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"pageSize",@"2",@"currPage",@"",@"sortid",@"",@"name",@"",@"type",nil];
    [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        self.freshArray=data[@"foodList"];
        NSLog(@"---%@---",self.freshArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        if (self.freshArray.count>0) {
            //名字
            self.freshNameLabel1.text=self.freshArray[0][@"name"];
            self.freshNameLabel2.text=self.freshArray[1][@"name"];
            self.freshNameLabel3.text=self.freshArray[2][@"name"];
            self.freshNameLabel4.text=self.freshArray[3][@"name"];
            self.freshNameLabel5.text=self.freshArray[4][@"name"];
            self.freshNameLabel6.text=self.freshArray[5][@"name"];
            //价格
            self.freshPriceLabel1.text=self.freshArray[0][@"formatPrice"];
            self.freshPriceLabel2.text=self.freshArray[1][@"formatPrice"];
            self.freshPriceLabel3.text=self.freshArray[2][@"formatPrice"];
            //规格
            self.freshSpecLabel1.text=self.freshArray[0][@"norm"];
            self.freshSpecLabel2.text=self.freshArray[1][@"norm"];
            self.freshSpecLabel3.text=self.freshArray[2][@"norm"];
            //照片
            //拼接图片网址·
            NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.freshArray[0][@"pic"]];
            //转换成url
            NSURL *imgUrl1 = [NSURL URLWithString:urlStr];
            [self.freshGoodsImage1 sd_setImageWithURL:imgUrl1];
            
            NSString *urlStr2 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.freshArray[1][@"pic"]];
            //转换成url
            NSURL *imgUrl2 = [NSURL URLWithString:urlStr2];
            [self.freshGoodsImage2 sd_setImageWithURL:imgUrl2];
            
            NSString *urlStr3 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.freshArray[2][@"pic"]];
            //转换成url
            NSURL *imgUrl3 = [NSURL URLWithString:urlStr3];
            [self.freshGoodsImage3 sd_setImageWithURL:imgUrl3];
            
            NSString *urlStr4 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.freshArray[3][@"pic"]];
            //转换成url
            NSURL *imgUrl4 = [NSURL URLWithString:urlStr4];
            [self.freshGoodsImage4 sd_setImageWithURL:imgUrl4];
            
            NSString *urlStr5 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.freshArray[4][@"pic"]];
            //转换成url
            NSURL *imgUrl5 = [NSURL URLWithString:urlStr5];
            [self.freshGoodsImage5 sd_setImageWithURL:imgUrl5];
            
            NSString *urlStr6 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.freshArray[5][@"pic"]];
            //转换成url
            NSURL *imgUrl6 = [NSURL URLWithString:urlStr6];
            [self.freshGoodsImage6 sd_setImageWithURL:imgUrl6];
        }else
        {
            
        }
    }];
}

/**
 *  最新推荐数据请求
 */
-(void)recomGoodsData
{
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"pageSize",@"2",@"currPage",@"",@"sortid",@"",@"name",@"5",@"type",nil];
    [RequestData getFoodListWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        self.recomArray=data[@"foodList"];
        NSLog(@"---%@---",self.recomArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        if (self.recomArray.count>0) {
            //名字
            self.recomNameLabel1.text=self.recomArray[0][@"name"];
            self.recomNameLabel2.text=self.recomArray[1][@"name"];
            self.recomNameLabel3.text=self.recomArray[2][@"name"];
            self.recomNameLabel4.text=self.recomArray[3][@"name"];
            self.recomNameLabel5.text=self.recomArray[4][@"name"];
            self.recomNameLabel6.text=self.recomArray[5][@"name"];
            //价格
            self.recomPriceLabel1.text=self.recomArray[0][@"formatPrice"];
            self.recomPriceLabel2.text=self.recomArray[1][@"formatPrice"];
            self.recomPriceLabel3.text=self.recomArray[2][@"formatPrice"];
            //规格
            self.recomSpecLabel1.text=self.recomArray[0][@"norm"];
            self.recomSpecLabel2.text=self.recomArray[1][@"norm"];
            self.recomSpecLabel3.text=self.recomArray[2][@"norm"];
            //照片
            //拼接图片网址·
            NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.recomArray[0][@"pic"]];
            //转换成url
            NSURL *imgUrl1 = [NSURL URLWithString:urlStr];
            [self.recomGoodsImage1 sd_setImageWithURL:imgUrl1];
            
            NSString *urlStr2 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.recomArray[1][@"pic"]];
            //转换成url
            NSURL *imgUrl2 = [NSURL URLWithString:urlStr2];
            [self.recomGoodsImage2 sd_setImageWithURL:imgUrl2];
            
            NSString *urlStr3 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.recomArray[2][@"pic"]];
            //转换成url
            NSURL *imgUrl3 = [NSURL URLWithString:urlStr3];
            [self.recomGoodsImage3 sd_setImageWithURL:imgUrl3];
            
            NSString *urlStr4 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.recomArray[3][@"pic"]];
            //转换成url
            NSURL *imgUrl4 = [NSURL URLWithString:urlStr4];
            [self.recomGoodsImage4 sd_setImageWithURL:imgUrl4];
            
            NSString *urlStr5 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.recomArray[4][@"pic"]];
            //转换成url
            NSURL *imgUrl5 = [NSURL URLWithString:urlStr5];
            [self.recomGoodsImage5 sd_setImageWithURL:imgUrl5];
            
            NSString *urlStr6 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.recomArray[5][@"pic"]];
            //转换成url
            NSURL *imgUrl6 = [NSURL URLWithString:urlStr6];
            [self.recomGoodsImage6 sd_setImageWithURL:imgUrl6];

        }else
        {
            
        }
    }];
}

/**
 *  自制菜品数据请求
 */
-(void)memberGoodsData
{
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"6",@"pageSize",@"1",@"currPage",nil];
    [RequestData getAllSelfFoodWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        self.memberArray=data[@"selfFoodList"];
        NSLog(@"---%@---",self.memberArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        if (self.memberArray.count>0) {
            //名字
            self.memberNameLabel1.text=self.memberArray[0][@"title"];
            self.memberNameLabel2.text=self.memberArray[1][@"title"];
            self.memberNameLabel3.text=self.memberArray[2][@"title"];
            self.memberNameLabel4.text=self.memberArray[3][@"title"];
            self.memberNameLabel5.text=self.memberArray[4][@"title"];
            self.memberNameLabel6.text=self.memberArray[5][@"title"];
            //照片
            //拼接图片网址·
            NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.memberArray[0][@"pic"]];
            //转换成url
            NSURL *imgUrl1 = [NSURL URLWithString:urlStr];
            [self.memberGoodsImage1 sd_setImageWithURL:imgUrl1];
            
            NSString *urlStr2 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.memberArray[1][@"pic"]];
            //转换成url
            NSURL *imgUrl2 = [NSURL URLWithString:urlStr2];
            [self.memberGoodsImage2 sd_setImageWithURL:imgUrl2];
            
            NSString *urlStr3 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.memberArray[2][@"pic"]];
            //转换成url
            NSURL *imgUrl3 = [NSURL URLWithString:urlStr3];
            [self.memberGoodsImage3 sd_setImageWithURL:imgUrl3];
            
            NSString *urlStr4 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.memberArray[3][@"pic"]];
            //转换成url
            NSURL *imgUrl4 = [NSURL URLWithString:urlStr4];
            [self.memberGoodsImage4 sd_setImageWithURL:imgUrl4];
            
            NSString *urlStr5 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.memberArray[4][@"pic"]];
            //转换成url
            NSURL *imgUrl5 = [NSURL URLWithString:urlStr5];
            [self.memberGoodsImage5 sd_setImageWithURL:imgUrl5];
            
            NSString *urlStr6 =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.memberArray[5][@"pic"]];
            //转换成url
            NSURL *imgUrl6 = [NSURL URLWithString:urlStr6];
            [self.memberGoodsImage6 sd_setImageWithURL:imgUrl6];
        }else{
            
        }
    }];
}


/**
 *  该方法在视图跳转时被触发
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AllGoods"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"0" forKey:@"type"];
    }
    if ([segue.identifier isEqualToString:@"RecomGoods"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"5" forKey:@"type"];
    }
}

#pragma mark == 图片点击，进入详情页 ==
/**
 *  点击新鲜菜品进入详情页
 */
-(void)tapFreshImage1
{
    int fid = (int)(self.freshGoodsImage1.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
    
}
-(void)tapFreshImage2
{
    int fid = (int)(self.freshGoodsImage2.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapFreshImage3
{
    int fid = (int)(self.freshGoodsImage3.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapFreshImage4
{
    int fid = (int)(self.freshGoodsImage4.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapFreshImage5
{
    int fid = (int)(self.freshGoodsImage5.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapFreshImage6
{
    int fid = (int)(self.freshGoodsImage6.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
/**
 *  点击推荐菜品进入详情页
 */
-(void)tapRecomGoodsImage1
{
    int fid = (int)(self.recomGoodsImage1.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapRecomGoodsImage2
{
    int fid = (int)(self.recomGoodsImage2.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapRecomGoodsImage3
{
    int fid = (int)(self.recomGoodsImage3.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapRecomGoodsImage4
{
    int fid = (int)(self.recomGoodsImage4.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapRecomGoodsImage5
{
    int fid = (int)(self.recomGoodsImage5.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}
-(void)tapRecomGoodsImage6
{
    int fid = (int)(self.recomGoodsImage6.tag -100);
    NSString *Fid = [NSString stringWithFormat:@"%d",fid];
    
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys:Fid,@"id", nil];
    
    [RequestData getFoodById:prama FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"yjh" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.navigationController pushViewController:detailV animated:YES];
    }];
}


@end
