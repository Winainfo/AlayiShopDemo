#import "FinallyViewController.h"

@interface FinallyViewController ()

@end

@implementation FinallyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cellView registerClass:[SequenceCollectionViewCell class] forCellWithReuseIdentifier:@"SequenceCollectionViewCell"];
    // 设置的背景图片
    self.cellView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SequenceCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SequenceCollectionViewCell" forIndexPath:indexPath];
    //设置背景图片
    //    UIImageView *Bg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"item_graph_cont_box_bg"]];
    //    cell.backgroundView=Bg;
    cell.imageView.image=[UIImage imageNamed:@"1.png"];
    cell.nameText.text=@"品名";
    cell.priceLable.text=@"¥5.5/斤";
    return cell;
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
