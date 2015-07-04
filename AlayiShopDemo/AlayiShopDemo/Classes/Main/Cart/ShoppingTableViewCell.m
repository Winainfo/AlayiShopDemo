#import "ShoppingTableViewCell.h"
#define SIZE  [UIScreen mainScreen].bounds.size.width


@implementation ShoppingTableViewCell


- (void)awakeFromNib {
    
    self.editorConstraintRight.constant = SIZE/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}




@end
