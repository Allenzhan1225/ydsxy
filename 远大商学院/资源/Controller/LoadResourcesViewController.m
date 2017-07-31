//
//  LoadResourcesViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/10.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "LoadResourcesViewController.h"
#import <WebKit/WebKit.h>

@interface LoadResourcesViewController ()<MBProgressHUDDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *web;
@property (nonatomic,strong) MBProgressHUD *HUD;
@property (nonatomic,strong) UIAlertController *alert;

@end

@implementation LoadResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_navTitle!=nil || ![_navTitle isEqual:@""]) {
        self.title=_navTitle;
    }
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRESOURCES,self.urlString]];
    NSLog(@"------url=%@------",self.urlString);
    self.web=[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
    self.web.navigationDelegate=self;
    [self.web loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.web];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.web animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
    
   _alert=[UIAlertController alertControllerWithTitle:nil message:@"加载资源失败，请检查网络或查看其他的资源，我们正在改进。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self popoverPresentationController];
    }];
    [_alert addAction:sureAction];
}

#pragma mark--WKNavigationDelegate
// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [_HUD hideAnimated:YES afterDelay:1];
}

#pragma mark--加载失败处理
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"error=%@",error);
    if([error code] == NSURLErrorCancelled)
    {
        return;
    }
    [_HUD hideAnimated:YES afterDelay:0];
    
    if ([error code] == (NSURLErrorTimedOut | NSURLErrorNetworkConnectionLost | NSURLErrorDNSLookupFailed | NSURLErrorResourceUnavailable)) {
        [self presentViewController:_alert animated:YES completion:nil];
    }
//    [self presentViewController:_alert animated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.alert removeFromParentViewController];
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
