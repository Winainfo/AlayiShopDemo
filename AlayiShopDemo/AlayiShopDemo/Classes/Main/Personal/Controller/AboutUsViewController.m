
#import "AboutUsViewController.h"
#import "RequestData.h"


@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *containTxt;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取首页广告图片数组
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys: @"3",@"id",nil];
    [RequestData getInfoById:prama FinishCallbackBlock:^(NSDictionary * data) {        
        NSLog(@" 加盟合作 == %@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = data [@"title"];
            self.containTxt.text = data [@"fmtContent"];
        });      
    }];
    //热销菜品
//    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys: nil];
//    [RequestData getAllHotFoodList:prama FinishCallbackBlock:^(NSDictionary *data) {
//        NSLog(@"====%@",data);
//    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
