//
//  AddressTableController.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
@interface AddressTableController : UITableViewController<UIAlertViewDelegate,ABPeoplePickerNavigationControllerDelegate,UITextFieldDelegate>
/**标识0.添加、1.修改*/
@property(retain,nonatomic)NSString *flag;
/**用户送货地址id当flag==0时，id应该为0；当flag==1时，id不能为0。*/
@property(retain,nonatomic)NSString *f_id;
@end
