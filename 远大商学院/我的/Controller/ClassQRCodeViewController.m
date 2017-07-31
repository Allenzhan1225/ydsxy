//
//  ClassQRCodeViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/30.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ClassQRCodeViewController.h"
#import "ClassDetailViewController.h"
#import "HomePageController.h"

@interface ClassQRCodeViewController ()<UIWebViewDelegate>{
    UIWebView *web;
}
@end

@implementation ClassQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    web=[[UIWebView alloc] init];
    web.frame=self.view.bounds;
    web.delegate=self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLStr]];
    [web loadRequest:request];
    [self.view addSubview:web];
    
    //Click on the //
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"prev"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
}

- (void)back{
    
     [self.navigationController popToRootViewControllerAnimated:YES];
    // 直接跳转到首页
//    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *tabbar=[sb instantiateViewControllerWithIdentifier:@"tabBarController"];
//    [self presentViewController:tabbar animated:YES completion:nil];
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
