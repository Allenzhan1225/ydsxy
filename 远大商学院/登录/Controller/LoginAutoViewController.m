//
//  LoginAutoViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/19.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "LoginAutoViewController.h"
#import "RequestLoginData.h"
#import "LoginController.h"

@interface LoginAutoViewController ()

@property (nonatomic,retain) NSUserDefaults *defaults;
@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,retain) NSString *messageStr;

@property (nonatomic,strong) LoginModel *model;

@end

@implementation LoginAutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.defaults=[NSUserDefaults standardUserDefaults];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView *backView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 20)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
    imgView.frame=CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [self.view addSubview:imgView];
    
    [self loginVC];
}

- (void)loginVC{
    NSString *login_name=[_defaults valueForKey:@"login_name"];
    NSString *login_password=[_defaults valueForKey:@"login_password"];
    
    // 登录
    [self getDataWithName:login_name withPassword:login_password];
}

// 解析数据
- (void)getDataWithName:(NSString *)name withPassword:(NSString *)password{
    // 获取登录网址
    NSString *stringOfLogin=[kURLOFUSERLOGIN stringByAppendingString:[NSString stringWithFormat:@"login_name=%@&login_password=%@",name,password]];
    // 转码
    NSString *encode=[stringOfLogin stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    RequestLoginData *loginData=[RequestLoginData new];
    [loginData requestDataWithURL:encode];
    loginData.manager=^(LoginModel *model,NSString *string){
//        temp.model=model;
        temp.messageStr=string;
        if ([self.messageStr isEqualToString:@"登录成功！"]) {
//            NSLog(@"1111");
            temp.model=model;
        }
        NSLog(@"self.messageStr1=%@",self.messageStr);
        [temp presentVC];
    };
}

- (void)presentVC{
    if ([self.messageStr isEqualToString:@"登录成功！"]) {
        UITabBarController *tabBar=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self presentViewController:tabBar animated:YES completion:nil];
    }else{
        LoginController *login=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginController"];
        login.loginSuccess=NO;
        [self presentViewController:login animated:YES completion:nil];
    }
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
