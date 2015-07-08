//
//  TableViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/8.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "TableViewController.h"
#import "UIImageView+WebCache.h"
//获得当前屏幕宽高点数（非像素）

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
@interface TableViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;
@property (retain,nonatomic) NSArray *imageArray;
@end

@implementation TableViewController

- (void)viewDidLoad {
    NSLog(@"%f",kScreenWidth);
    [super viewDidLoad];
    //去掉表格线
    self.tableView.separatorStyle=NO;
    //代理
    self.myScrollView.delegate=self;
    //页面控制的当前页
    self.myPageControl.currentPage = 0;
    //滚动视图
    [self scrollViewAdv];
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
@end
