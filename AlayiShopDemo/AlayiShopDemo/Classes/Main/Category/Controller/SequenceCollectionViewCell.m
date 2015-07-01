#import "SequenceCollectionViewCell.h"

@implementation SequenceCollectionViewCell

- (void)awakeFromNib {
    //关闭交互
    self.nameText.userInteractionEnabled = NO;
    //cell单元格倒角
    self.viewForBaselineLayout.layer.cornerRadius = 6.0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SequenceCollectionViewCell"/*标示符*/ owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
