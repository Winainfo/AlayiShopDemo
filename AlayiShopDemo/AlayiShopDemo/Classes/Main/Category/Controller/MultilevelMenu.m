
#import "MultilevelMenu.h"
#import "MultilevelTableViewCell.h"
#import "DetailViewController.h"
#import "MultilevelCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "RequestData.h"
#define kImageDefaultName @"tempShop"
#define kMultilevelCollectionViewCell @"MultilevelCollectionViewCell"
#define kMultilevelCollectionHeader   @"CollectionHeader"//CollectionHeader
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface MultilevelMenu()
@property(strong,nonatomic ) UITableView * leftTablew;
@property(strong,nonatomic ) UICollectionView * rightCollection;
@property(assign,nonatomic) BOOL isReturnLastOffset;
@property(retain,nonatomic) NSArray *leftArray;
@property(retain,nonatomic) NSArray *rightArray;
@end
@implementation MultilevelMenu

-(id)initWithFrame:(CGRect)frame WithSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    
    if (self  == [super initWithFrame:frame]) {
        
        
        _block=selectIndex;
        self.leftSelectColor=[UIColor blackColor];
        self.leftSelectBgColor=[UIColor whiteColor];
        self.leftBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftSeparatorColor=UIColorFromRGB(0xE5E5E5);
        self.leftUnSelectBgColor=UIColorFromRGB(0xF3F4F6);
        self.leftUnSelectColor=[UIColor blackColor];
        
        _selectIndex=0;
        
        /**
         左边的视图
         */
        self.leftTablew=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftWidth, frame.size.height)];
        self.leftTablew.dataSource=self;
        self.leftTablew.delegate=self;
        
        self.leftTablew.tableFooterView=[[UIView alloc] init];
        [self addSubview:self.leftTablew];
        self.leftTablew.backgroundColor=self.leftBgColor;
        if ([self.leftTablew respondsToSelector:@selector(setLayoutMargins:)]) {
            self.leftTablew.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.leftTablew respondsToSelector:@selector(setSeparatorInset:)]) {
            self.leftTablew.separatorInset=UIEdgeInsetsZero;
        }
        self.leftTablew.separatorColor=self.leftSeparatorColor;
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:nil];
        [RequestData getFoodSortList:params FinishCallbackBlock:^(NSDictionary *data) {
            self.leftArray=data[@"sortList"];
            //调用主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftTablew reloadData];
            });
        }];
        
        
        /**
         右边的视图
         */
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing=0.f;//左右间隔
        flowLayout.minimumLineSpacing=5.0f;
        float leftMargin =0;
        self.rightCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(kLeftWidth+leftMargin,5,kScreenWidth-kLeftWidth-leftMargin*2,frame.size.height) collectionViewLayout:flowLayout];
        self.rightCollection.delegate=self;
        self.rightCollection.dataSource=self;
        UINib *nib=[UINib nibWithNibName:kMultilevelCollectionViewCell bundle:nil];
        
        [self.rightCollection registerNib: nib forCellWithReuseIdentifier:kMultilevelCollectionViewCell];
        
        
        UINib *header=[UINib nibWithNibName:kMultilevelCollectionHeader bundle:nil];
        [self.rightCollection registerNib:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kMultilevelCollectionHeader];
        
        [self addSubview:self.rightCollection];
        
        
        self.isReturnLastOffset=YES;
        
        self.rightCollection.backgroundColor=self.leftSelectBgColor;
        
        self.backgroundColor=self.leftSelectBgColor;
        NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",[NSString stringWithFormat:@"%ld",(long)_selectIndex+1],@"sortid",@"",@"name",@"",@"type",nil];
        [RequestData getFoodListWithPage:param FinishCallbackBlock:^(NSDictionary *data) {
            self.rightArray=data[@"foodList"];
            //调用主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.rightCollection reloadData];
            });
        }];
    }
    return self;
}

//代理方法，导航栏跳转
-(void)pushView:(id)view
{
}

-(void)setNeedToScorllerIndex:(NSInteger)needToScorllerIndex{
    if (needToScorllerIndex>0) {
        
        /**
         *  滑动到 指定行数
         */
        [self.leftTablew selectRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        
        MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[self.leftTablew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:needToScorllerIndex inSection:0]];
        UILabel * line=(UILabel*)[cell viewWithTag:100];
        line.backgroundColor=cell.backgroundColor;
        cell.nameLabel.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
        _selectIndex=needToScorllerIndex;
        
        [self.rightCollection reloadData];
        
    }
    _needToScorllerIndex=needToScorllerIndex;
}
-(void)setLeftBgColor:(UIColor *)leftBgColor{
    _leftBgColor=leftBgColor;
    self.leftTablew.backgroundColor=leftBgColor;
    
}
-(void)setLeftSelectBgColor:(UIColor *)leftSelectBgColor{
    
    _leftSelectBgColor=leftSelectBgColor;
    self.rightCollection.backgroundColor=leftSelectBgColor;
    
    self.backgroundColor=leftSelectBgColor;
}
-(void)setLeftSeparatorColor:(UIColor *)leftSeparatorColor{
    _leftSeparatorColor=leftSeparatorColor;
    self.leftTablew.separatorColor=leftSeparatorColor;
}
-(void)reloadData{
    
    [self.leftTablew reloadData];
    [self.rightCollection reloadData];
    
}
#pragma mark---左边的tablew 代理
#pragma mark--deleagte

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier=@"MultilevelTableViewCell";
    MultilevelTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (!cell) {
        cell=[[NSBundle mainBundle] loadNibNamed:@"MultilevelTableViewCell" owner:self options:nil][0];
        
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(kLeftWidth-0.5, 0, 0.5, 44)];
        label.backgroundColor=tableView.separatorColor;
        [cell addSubview:label];
        label.tag=100;
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.nameLabel.text=self.leftArray[indexPath.row][@"name"];
    
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    
    if (indexPath.row==self.selectIndex) {
        cell.nameLabel.textColor=self.leftSelectColor;
        cell.backgroundColor=self.leftSelectBgColor;
        line.backgroundColor=cell.backgroundColor;
    }
    else{
        cell.nameLabel.textColor=self.leftUnSelectColor;
        cell.backgroundColor=self.leftUnSelectBgColor;
        line.backgroundColor=tableView.separatorColor;
        
    }
    
    
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.nameLabel.textColor=self.leftSelectColor;
    cell.backgroundColor=self.leftSelectBgColor;
    _selectIndex=indexPath.row;
    rightMeun * title=self.allData[indexPath.row];
    
    
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=cell.backgroundColor;
    
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset=NO;
    
    
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",[NSString stringWithFormat:@"%ld",(long)_selectIndex+1],@"sortid",@"",@"name",@"",@"type",nil];
    [RequestData getFoodListWithPage:param FinishCallbackBlock:^(NSDictionary *data) {
        self.rightArray=data[@"foodList"];
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.rightCollection reloadData];
        });
    }];
    
    if (self.isRecordLastScroll) {
        [self.rightCollection scrollRectToVisible:CGRectMake(0, title.offsetScorller, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    else{
        
        [self.rightCollection scrollRectToVisible:CGRectMake(0, 0, self.rightCollection.frame.size.width, self.rightCollection.frame.size.height) animated:NO];
    }
    
    
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    MultilevelTableViewCell * cell=(MultilevelTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.nameLabel.textColor=self.leftUnSelectColor;
    UILabel * line=(UILabel*)[cell viewWithTag:100];
    line.backgroundColor=tableView.separatorColor;
    
    cell.backgroundColor=self.leftUnSelectBgColor;
}

#pragma mark---imageCollectionView------------------
//内容
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.rightArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MultilevelCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kMultilevelCollectionViewCell forIndexPath:indexPath];
    
    cell.goodsNameLabel.text=self.rightArray[indexPath.row][@"name"];
    cell.goodsPriceLabel.text=self.rightArray[indexPath.row][@"formatPrice"];
    cell.goodsSpecLabel.text=self.rightArray[indexPath.row][@"norm"];
    cell.gID = self.rightArray[indexPath.row][@"id"];
   // cell.backgroundColor=[UIColor clearColor];
    cell.goodsImagView.backgroundColor=UIColorFromRGB(0xF8FCF8);
    //照片
    //拼接图片网址·
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.rightArray[indexPath.row][@"pic"]];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [cell.goodsImagView sd_setImageWithURL:imgUrl];
    cell.layer.borderColor=CFBridgingRetain(([UIColor darkGrayColor]));
    cell.layer.borderWidth=0.3;
    return cell;
}
//布局
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 150);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 5, 20, 5);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kScreenWidth,44};
    return size;
}
//点击进入详情页
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MultilevelCollectionViewCell *cell= [MultilevelCollectionViewCell new];
    cell.gID = self.rightArray[indexPath.row][@"id"];
    
    //请求详情页信息
    NSDictionary *params2=[NSDictionary dictionaryWithObjectsAndKeys:cell.gID,@"id", nil];
    [RequestData getFoodById:params2 FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"=======详情信息：%@",data);
        //跳转不同的故事版
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailViewController *detailV = [storyboard instantiateViewControllerWithIdentifier:@"详情View"];
        detailV.detailDic = data;
        NSLog(@"=======详情信息：%@",detailV.detailDic);
        [self.delete pushView:detailV];
        
    }];
    
}



#pragma mark---记录滑动的坐标
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.rightCollection]) {
        
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightCollection]) {
        
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.rightCollection] && self.isReturnLastOffset) {
        rightMeun * title=self.allData[self.selectIndex];
        
        title.offsetScorller=scrollView.contentOffset.y;
        
        
    }
}

#pragma mark--Tools
-(void)performBlock:(void (^)())block afterDelay:(NSTimeInterval)delay{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end


@implementation rightMeun



@end
