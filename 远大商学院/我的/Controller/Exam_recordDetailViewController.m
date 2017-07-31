//
//  Exam_recordDetailViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "Exam_recordDetailViewController.h"
@interface Exam_recordDetailViewController ()</*MBProgressHUDDelegate,*/UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *web;
@property (nonatomic,strong) MBProgressHUD *HUD;

@end

@implementation Exam_recordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=_titleName;
    self.web=[[UIWebView alloc] initWithFrame:self.view.frame];
    self.web.delegate=self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadURL]];
    [self.web loadRequest:request];
    [self.view addSubview:self.web];
    
//    _HUD=[[MBProgressHUD alloc] initWithView:self.view];
//    _HUD.delegate=self;
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
//    [self.web addSubview:_HUD];
//    [_HUD show:YES];
//    _HUD.dimBackground=YES;
    [_HUD showAnimated:YES];
}

#pragma mark--UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [_HUD hide:YES afterDelay:2];
//    _HUD.dimBackground=NO;
    [_HUD hideAnimated:YES afterDelay:2];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error=%@",error);
    if([error code] == NSURLErrorCancelled)
    {
        return;
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
