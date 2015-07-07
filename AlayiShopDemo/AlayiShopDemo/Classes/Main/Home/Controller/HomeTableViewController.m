
#import "HomeTableViewController.h"
#import "UIImageView+WebCache.h"
#import "RequestData.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface HomeTableViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *adView;
@property (retain,nonatomic) NSMutableArray *hotImages;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置代理
    self.adView.delegate = self;
    //滚动视图背景色
   self.adView.backgroundColor = [UIColor colorWithRed:0.866 green:0.853 blue:0.895 alpha:1.000];
    //页面控制的当前页
    self.myPageControl.currentPage = 0;
    
    self.hotImages = [NSMutableArray arrayWithCapacity:1];
    //获取首页广告图片数组
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys: nil];
    [RequestData getAllHotFoodList:prama FinishCallbackBlock:^(NSDictionary * data) {
//        NSLog(@"data == %@",data[@"hotFoodList"]);
        self.hotImages = data[@"hotFoodList"];
         NSLog(@" self.HOtImages == %@",self.hotImages);
        //设置滚动视图的包含的视图大小和图片
        [self scrollViewWithFrame:self.adView.frame andImages:self.hotImages];
        //设置定时滚动
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollAdView) userInfo:nil repeats:YES];
    }];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.000 green:0.517 blue:0.000 alpha:1.000];
    
}


-(void)scrollViewWithFrame:(CGRect)frame andImages:(NSArray *)images
{
    self.adView.showsHorizontalScrollIndicator = NO;
    self.adView.showsVerticalScrollIndicator = NO;
    self.adView.pagingEnabled = YES;
   //不显示边框外视图
    self.adView.bounces= NO;
    self.adView.contentSize = CGSizeMake(self.adView.frame.size.width*images.count, self.adView.frame.size.height);
    self.myPageControl.numberOfPages = images.count;
    //为滚动视图添加图片
    for (int i=0; i<images.count; i++) {
        //拼接图片网址·
        NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",images[i][@"pic"]];
        //转换成url
        NSURL *imgUrl = [NSURL URLWithString:urlStr];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
        [imageV sd_setImageWithURL:imgUrl];
        [self.adView addSubview:imageV];
    }
    
}

//定时器自动滚动广告
- (void)scrollAdView
{
    int currentNum=(self.adView.contentOffset.x/self.adView.frame.size.width+1);
    if (currentNum == 5) {
        currentNum = 0;
    }
    self.adView.contentOffset=CGPointMake(self.adView.frame.size.width*currentNum,0);
    self.myPageControl.currentPage = currentNum;
    
}
#pragma mark 手动拖动的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/self.adView.frame.size.width;
    self.myPageControl.currentPage=page;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
