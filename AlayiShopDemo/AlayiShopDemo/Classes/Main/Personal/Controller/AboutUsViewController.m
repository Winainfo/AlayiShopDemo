
#import "AboutUsViewController.h"
#import "RequestData.h"


@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *containTxt;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取首页广告图片数组
    NSDictionary *prama = [NSDictionary dictionaryWithObjectsAndKeys: @"1",@"id",nil];
    [RequestData getInfoById:prama FinishCallbackBlock:^(NSDictionary * data) {        
        NSLog(@" 关于我们 == %@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = data [@"title"];
            self.containTxt.text = data [@"fmtContent"];
        });      
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
