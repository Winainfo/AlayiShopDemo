//
//  AddressTableController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AddressTableController.h"
#import "SettleController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "OrderTool.h"
@interface AddressTableController ()
/**收货人*/
@property (weak, nonatomic) IBOutlet UITextField *receivename;
/**收货人电话*/
@property (weak, nonatomic) IBOutlet UITextField *telephone;
/**送货地址*/
@property (weak, nonatomic) IBOutlet UITextField *sendaddress;


@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AddressTableController
@synthesize flag;
//隐藏和显示底部标签栏
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([flag isEqualToString:@"0"]) {
        self.title=@"新建收货地址";
        self.f_id=@"0";
    }else if([flag isEqualToString:@"1"]){
        self.title=@"编辑收货地址";
    }
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    //监听文本输入框的改变
    //1.拿到通知中心
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.sendaddress];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.receivename];
     [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.telephone];
    //需要上传的参数
    NSDictionary *dicy=@{@"id":self.f_id};
    [RequestData getUserSendAddressById:dicy FinishCallbackBlock:^(NSDictionary *data) {
        self.telephone.text=data[@"userSendAddress"][@"telephone"];
        self.sendaddress.text=data[@"userSendAddress"][@"sendaddress"];
        self.receivename.text=data[@"userSendAddress"][@"receivename"];
    }];
}

/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    //移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  文本改变事件
 */
-(void)textChange{
    //1.同时改变文本值，登录才可用
    if (self.sendaddress.text.length>0&&self.receivename.text.length>0&&self.telephone.text.length>0) {
        //改变btn背景颜色
        self.saveBtn.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1];
        //改变字体颜色
        [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //关闭交互
        self.saveBtn.userInteractionEnabled=YES;
        
    }else if (self.sendaddress.text.length>0||self.receivename.text.length>0||self.telephone.text.length>0)
    {
        //改变btn背景颜色
        self.saveBtn.backgroundColor=[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
        //改变字体颜色
        [self.saveBtn setTitleColor:[UIColor colorWithRed:189.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1] forState:UIControlStateNormal];
        //关闭交互
        self.saveBtn.userInteractionEnabled=NO;
    }
}

/**
 保存地址
 */
- (IBAction)saveAddrss:(UIButton *)sender {
    AccountModel *account=[AccountTool account];
    OrderModel *order=[OrderModel new];
    NSString *sendaddress=[self.sendaddress.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *telephone=[self.telephone.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *receivename=[self.receivename.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    order.sendaddress=self.sendaddress.text;
    order.telephone=self.telephone.text;
    order.receivename=self.receivename.text;
    [OrderTool saveOrder:order];
    //需要上传的参数
    NSDictionary *dicy=@{@"userid":account.userId,@"username":account.name,@"flag":flag,@"id":self.f_id,@"sendaddress":sendaddress,@"telephone":telephone,@"receivename":receivename};
    [RequestData saveUserSendAddress:dicy FinishCallbackBlock:^(NSDictionary *data) {
        if ([data[@"code"] isEqualToString:@"0"]) {
            //指定跳转
            for(UIViewController *controller in self.navigationController.viewControllers) {
                if([controller isKindOfClass:[SettleController class]]){
                    SettleController *settle=(SettleController *)controller;
                    [self.navigationController popToViewController:settle animated:YES];
                }
            }
        }else{
            //初始化AlertView
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                 
                                                          message:@"地址提交失败"
                                 
                                                         delegate:nil
                                 
                                                cancelButtonTitle:@"确定"
                                 
                                                otherButtonTitles:nil];
            [alert show];
        }
    }];
    }

#pragma mark实现通讯录的代理
- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    // [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

/**
 *   选中某一个联系人的某一个属性时就会调用 --IOS7
 *
 *  @param 
 Picker <#peoplePicker description#>
 *  @param person       <#person description#>
 *  @param property     <#property description#>
 *  @param identifier   <#identifier description#>
 *
 *  @return <#return value description#>
 */
- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    //retrieve number
    NSLog(@"tapped number");
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
    NSString *phone = nil;
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if ((ABMultiValueGetCount(phoneNumbers) > 0)) {
        phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, identifier);
    } else {
        phone = @"[None]";
    }
    NSLog(@"retrieved number: %@", phone);
    
    if ([self.telephone.text length] == 0) {
        self.telephone.text= phone;
    } else {
        NSString* fullNumbers = [NSString stringWithFormat:@"%@, %@", self.telephone.text, phone];
        NSLog(@"%@", fullNumbers);
        self.telephone.text = fullNumbers;
    }

        NSString* fullNumbers = [NSString stringWithFormat:@"%@%@", lastName,firstName];
        self.receivename.text=fullNumbers;
//    }else{
//        NSString* fullNumbers = [NSString stringWithFormat:@"%@, %@", self.telephone.text, phone];
//        NSLog(@"%@", fullNumbers);
//        self.telephone.text = fullNumbers;
//    }
    
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

/**
 *  选中某一个联系人的某一个属性时就会调用 --IOS8
 *
 *  @param peoplePicker <#peoplePicker description#>
 *  @param person       <#person description#>
 *  @param property     <#property description#>
 *  @param identifier   <#identifier description#>
 */
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    //retrieve number
    NSLog(@"tapped number");
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, property);
    NSString *phone = nil;
    if ((ABMultiValueGetCount(phoneNumbers) > 0)) {
        phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, identifier);
    } else {
        phone = @"[None]";
    }
    NSLog(@"retrieved number: %@", phone);
    
    //retrieve first and last name
    NSString* firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString* lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"retrieved first name: %@", firstName);
    NSLog(@"retrieve last name: %@", lastName);
    
    
    if ([self.telephone.text length] == 0) {
        self.telephone.text= phone;
    } else {
        NSString* fullNumbers = [NSString stringWithFormat:@"%@, %@", self.telephone.text, phone];
        NSLog(@"%@", fullNumbers);
        self.telephone.text = fullNumbers;
    }
       NSString* fullNumbers = [NSString stringWithFormat:@"%@%@", lastName,firstName];
        self.receivename.text=fullNumbers;
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPeople:(UIButton *)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

@end
