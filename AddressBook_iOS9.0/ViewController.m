//
//  ViewController.m
//  AddressBook_iOS9.0
//
//  Created by luxtmxw on 16/1/1.
//  Copyright © 2016年 luxtmxw. All rights reserved.
//

#import "ViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController


//添加联系人
- (void)addContact {
    //创建可变联系人对象
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    
    contact.givenName = @"xiaoya";    //联系人名
    contact.familyName = @"jiang";      //联系人姓
    //添加联系人邮箱
    CNLabeledValue *homeMail = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:@"464918717@qq.com"];
    //工作邮箱
    CNLabeledValue *workMail = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:@"464918717@qq.com"];
    contact.emailAddresses = @[homeMail, workMail];
    //设置联系人电话
    contact.phoneNumbers = @[[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:@"97052052020"]]];
    //设置联系人地址
    CNMutablePostalAddress *homeAdress = [[CNMutablePostalAddress alloc] init];
    homeAdress.street = @"木行弄";
    homeAdress.city = @"苏州";
    homeAdress.state = @"江苏省";
    homeAdress.country = @"中国";
    homeAdress.postalCode = @"14号";
    contact.postalAddresses = @[[CNLabeledValue labeledValueWithLabel:CNLabelHome value:homeAdress]];
    
    //设置生日
    NSDateComponents *birthday = [[NSDateComponents alloc] init];
    birthday.day = 24;
    birthday.month = 1;
    birthday.year = 1991;
    contact.birthday = birthday;
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *realPath = [resourcePath stringByAppendingPathComponent:@"1.png"];
    NSData *imageData = [NSData dataWithContentsOfFile:realPath];
    contact.imageData = imageData;
    
    //存储联系人请求
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addContact:contact toContainerWithIdentifier:nil];
    
    //联系人写入
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *error = nil;
    [store executeSaveRequest:saveRequest error:&error];
    
    
}
//显示联系人
- (IBAction)showContact:(id)sender {
    CNContactPickerViewController *contactionPickVC = [[CNContactPickerViewController alloc] init];
    contactionPickVC.delegate = self;
    [self presentViewController:contactionPickVC animated:YES completion:nil];
}
//选择联系人
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    NSLog(@"%@--", contact.givenName);
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addContact];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
