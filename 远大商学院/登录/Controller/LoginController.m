//
//  LoginController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/13.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "LoginController.h"
#import "HomePageController.h"
#import "ForgetPasswordController.h"
#import "RequestLoginData.h"
#import "LoginModel.h"

#define URLOfLogin @"http://peixun.xgyuanda.com/appc/login.html?token=sxyapp&"

@interface LoginController ()<UITextFieldDelegate>
// 用户名、密码
@property (retain, nonatomic) UITextField *userName;
@property (retain, nonatomic) UITextField *userPassword;
@property (retain, nonatomic) UIImageView *imgOfUser;
@property (retain,nonatomic) UIButton *loginBtn;
@property (nonatomic,retain) UIImageView *passwordShow;

@property (nonatomic,retain) NSUserDefaults *defaults;

// 提示框
@property (nonatomic,strong) UIAlertController *alert;
@property (nonatomic,strong) MBProgressHUD *HUD;

@property (nonatomic,strong) LoginModel *model;
@property (nonatomic,strong) NSString *messageStr;

@property (nonatomic,assign) BOOL isTap;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
//    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _HUD.label.text=@"正在加载中···";
//    [_HUD showAnimated:YES];
    
    [self buildUI];
}

- (void)buildUI{
    // 初始化提示框
    self.alert=[UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [self.alert addAction:cancle];
    
    // logo
    self.imgOfUser=[[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH/4.0, (kHEIGHT/5.0*2-kWIDTH/2.0)/2, kWIDTH/2.0, kWIDTH/2.0)];
    self.imgOfUser.image=[UIImage imageNamed:@"logo"];
    // 登录logo设置
    _imgOfUser.layer.masksToBounds=YES;
    _imgOfUser.layer.cornerRadius=kWIDTH/4.0;
    [self.view addSubview:self.imgOfUser];
    
    self.userName=[[UITextField alloc] initWithFrame:CGRectMake(40, kHEIGHT/5.0*2, kWIDTH-80, 40)];
    self.userName.font=[UIFont systemFontOfSize:17];
    NSString *login_name=[_defaults valueForKey:@"login_name"];
    if (login_name!=nil && ![login_name isEqual:@""]) {
        self.userName.text=login_name;
    }else{
        self.userName.placeholder=@"用户名";
    }
    [self.view addSubview:self.userName];
    [self setUpLeftViewAndLineWithKinds:@"account"];
    
    self.userPassword=[[UITextField alloc] initWithFrame:CGRectMake(40, kHEIGHT/5.0*2+60, kWIDTH-80, 40)];
    NSString *login_password=[_defaults valueForKey:@"login_password"];
    if (login_password!=nil && ![login_password isEqual:@""]) {
        self.userPassword.text=login_password;
    }else{
        self.userPassword.placeholder=@"密码";
    }
    // 密码密文输入
    _userPassword.secureTextEntry=YES;
    self.userPassword.font=[UIFont systemFontOfSize:17];
    [self.view addSubview:self.userPassword];
    [self setUpLeftViewAndLineWithKinds:@"password"];
    
    // text代理设置
    [self setTextDelegate];
    
    // 登录按钮和忘记密码
    [self setUpBtn];
}

// 设置icon和下划线
- (void)setUpLeftViewAndLineWithKinds:(NSString *)kinds{
    // icon
    UIImageView *icon=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    icon.contentMode=UIViewContentModeCenter;
    self.passwordShow=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 32, 20)];
    // 设置下划线
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 38, kWIDTH-80, 1)];
    line.backgroundColor=[UIColor lightGrayColor];
    if ([kinds isEqualToString:@"account"]) {
        icon.image=[UIImage imageNamed:kinds];
        self.userName.leftView=icon;
        self.userName.leftViewMode=UITextFieldViewModeAlways;
        [self.userName addSubview:line];
    }else if ([kinds isEqualToString:@"password"]){
        icon.image=[UIImage imageNamed:kinds];
        self.userPassword.leftView=icon;
        self.userPassword.leftViewMode=UITextFieldViewModeAlways;
        [self.userPassword addSubview:line];
        
        // 显示、隐藏密码
        _passwordShow.image=[UIImage imageNamed:@"show"];
        self.userPassword.rightView=_passwordShow;
        self.userPassword.rightViewMode=UITextFieldViewModeAlways;
        _passwordShow.userInteractionEnabled=YES;
        self.isTap=0;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.userPassword.rightView addGestureRecognizer:tap];
    }
}

- (void)tap{
    // 点击区分isTap
    if (self.isTap==0) {
        self.passwordShow.image=[UIImage imageNamed:@"hide"];
        self.userPassword.secureTextEntry=NO;
        self.isTap=1;
    }else{
        self.passwordShow.image=[UIImage imageNamed:@"show"];
        self.userPassword.secureTextEntry=YES;
        self.isTap=0;
    }
}

- (void)setUpBtn{
    // 登录
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn=loginBtn;
    loginBtn.frame=CGRectMake(40, kHEIGHT/5.0*2+120, kWIDTH-80, 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录中···" forState:UIControlStateSelected];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    
    [loginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor=[UIColor whiteColor];
    
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.masksToBounds=YES;
    loginBtn.layer.cornerRadius=8;
    [self.view addSubview:loginBtn];
    
    // 忘记密码
    UIButton *forgetPasswordBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    forgetPasswordBtn.frame=CGRectMake(40, kHEIGHT/5.0*2+170, 100, 40);
    [forgetPasswordBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetPasswordBtn.backgroundColor=[UIColor clearColor];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPassword) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:forgetPasswordBtn];
}

- (void)setTextDelegate{
    self.userName.delegate=self;
    self.userPassword.delegate=self;
    if ([self.userName canBecomeFirstResponder] || [self.userPassword canBecomeFirstResponder]) {
        [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0];
    }
}

// 弹出键盘
- (void)showKeyboard{
    [self.userName becomeFirstResponder];
    [self.userPassword becomeFirstResponder];
}

//  回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 登录跳转界面
- (void)login{
    // 判断登录密码是否是在6-20位之间
    if ([self.userPassword.text length]<=20 && [self.userPassword.text length]>=6) {
        AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        if (appDlg.isReachable==1) {
            [self getData];
        }else{
            self.alert.message=@"请联网重试";
            [self presentViewController:self.alert animated:YES completion:nil];
        }
    }else{
        self.alert.message=@"密码长度输入不对，请重新输入!";
        [self presentViewController:self.alert animated:YES completion:nil];
    }
}

// 解析数据
- (void)getData{
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
    // 获取登录网址
    NSString *stringOfLogin=[kURLOFUSERLOGIN stringByAppendingString:[NSString stringWithFormat:@"login_name=%@&login_password=%@",_userName.text,_userPassword.text]];
    // 转码
    NSString *encode=[stringOfLogin stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    RequestLoginData *loginData=[RequestLoginData new];
    [loginData requestDataWithURL:encode];
    loginData.manager=^(LoginModel *model,NSString *string){
        temp.model=model;
        temp.messageStr=string;
//        NSLog(@"model=%@",model);
        [self presentView];
    };
}

// 判断跳转
- (void)presentView{
    // 密码符合要求，请求登录
    if ([self.messageStr isEqualToString:@"登录成功！"]) {
        [self storageLoginMessage];
        // 跳转到主页界面
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabBar=[sb instantiateViewControllerWithIdentifier:@"tabBarController"];
        // 隐藏HUD
        [_HUD hideAnimated:YES afterDelay:0];
        
        [self presentViewController:tabBar animated:YES completion:nil];
    }else{
        self.alert.message=@"账号或密码输入错误，请重新输入!";
        // 隐藏HUD
        [_HUD hideAnimated:YES afterDelay:0];
        [self presentViewController:self.alert animated:YES completion:nil];
    }
}

// 登陆，存储账号信息
- (void)storageLoginMessage{
    [_defaults setInteger:_model.id forKey:@"u_id"];
    [_defaults setInteger:_model.is_send_message forKey:@"is_send_message"];
    [_defaults setObject:_userName.text forKey:@"login_name"];
    [_defaults setObject:_userPassword.text forKey:@"login_password"];
    [_defaults synchronize];
}

// 忘记密码处理方法
- (void)forgetPassword{
    NSLog(@"忘记密码了···");
    ForgetPasswordController *forgetPassword=[ForgetPasswordController new];
    [self presentViewController:forgetPassword animated:YES completion:nil];
}
@end
