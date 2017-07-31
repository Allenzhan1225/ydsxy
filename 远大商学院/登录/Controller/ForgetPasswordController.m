//
//  ForgetPasswordController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/1.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ForgetPasswordController.h"

@interface ForgetPasswordController ()

@end

@implementation ForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
}

- (void)buildUI{
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 64)];
    imgView.image=[UIImage imageNamed:@"forgetPasswordBackgreound"];
    imgView.userInteractionEnabled=YES;
    [self.view addSubview:imgView];
    // title
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kWIDTH/2-50, 20, 100, 44)];
    label.text=@"忘记密码";
    label.font=[UIFont systemFontOfSize:25];
    label.textAlignment=NSTextAlignmentCenter;
    [imgView addSubview:label];
    
    // 返回btn
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5, 30, 60, 30);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:backBtn];
    // introduce
    UILabel *introduce=[[UILabel alloc] initWithFrame:CGRectMake(20, 74, kWIDTH-40, 30)];
    introduce.text=@"密码说明:";
    introduce.textColor=[UIColor redColor];
    introduce.font=[UIFont systemFontOfSize:22];
    [self.view addSubview:introduce];
    
    for (int i=0; i<3; i++) {
        UILabel *detailIntroduce=[[UILabel alloc] initWithFrame:CGRectMake(20, 110+60*i, kWIDTH-40, 60)];
        if (i==0) {
            detailIntroduce.text=@"远大商学院手机端app和WAP远大商学院网站两者密码一致。";
        }else if (i==1){
            detailIntroduce.text=@"若您是第一次登陆，初始密码为默认为六位数密码。";
        }else{
            detailIntroduce.text=@"若您遗忘密码，请您到商学院找常雅兰或王琴进行密码重置。";
        }
        detailIntroduce.numberOfLines=0;
        [self.view addSubview:detailIntroduce];
    }
    
    // suggest
    UILabel *suggest=[[UILabel alloc] initWithFrame:CGRectMake(20, 290, kWIDTH-40, 30)];
    suggest.text=@"密码建议:";
    suggest.textColor=[UIColor orangeColor];
    suggest.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:suggest];
    
    for (int i=0; i<2; i++) {
        UILabel *detailSuggest=[[UILabel alloc] init];
        if (i==0) {
            detailSuggest.frame=CGRectMake(20, 320, kWIDTH-40, 70);
            detailSuggest.text=@"首次登陆或者重置密码后登陆，请立即修改密码，日后请定期修改密码。";
        }else{
            detailSuggest.frame=CGRectMake(20, 390, kWIDTH-40, 90);
            detailSuggest.text=@"请妥善保管及记住密码，谨防泄漏，以确保密码由用户专属所有，利用账号和密码登陆远大商学院后都视为本人操作，用户自行承担相应的责任。";
        }
        detailSuggest.numberOfLines=0;
        [self.view addSubview:detailSuggest];
    }
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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
