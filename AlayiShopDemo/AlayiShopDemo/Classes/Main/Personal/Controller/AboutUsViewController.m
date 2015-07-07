
#import "AboutUsViewController.h"
#import "RequestData.h"


@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *containTxt;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavStyle];
    
    //获取首页广告图片数组
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys: @"1",@"id",nil];
    [RequestData getInfoById:prama FinishCallbackBlock:^(NSDictionary * data) {        
//        NSLog(@" 关于我们 == %@",data[@"info"][@"content"]);
        NSLog(@"加盟我们 == %@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = data [@"info"][@"title"];
            self.containTxt.text = data [@"info"][@"content"];
        });      
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
