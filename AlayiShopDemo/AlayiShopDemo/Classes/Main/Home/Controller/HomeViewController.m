#import "HomeViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *adView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    CGRect temp = self.adView.frame;
//    temp.size.width = WIDTH;
//    temp.size.height = 140;
//    self.adView.frame = temp;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.000 green:0.517 blue:0.000 alpha:1.000];
    
    
   
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
