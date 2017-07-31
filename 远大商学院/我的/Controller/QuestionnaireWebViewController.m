//
//  QuestionnaireWebViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/13.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "QuestionnaireWebViewController.h"
#import "LoadResourcesViewController.h"

@interface QuestionnaireWebViewController ()<UIWebViewDelegate,UMSocialUIDelegate>

@property (nonatomic,retain) UIWebView *web;
@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation QuestionnaireWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_navTitle!=nil || ![_navTitle isEqual:@""]) {
        self.title=_navTitle;
        if (_isHomePage==YES) {
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
        }else if (_isPerformSystem==YES){
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"绩效说明书" style:UIBarButtonItemStyleDone target:self action:@selector(PSIntroduce)];
        }
    }
    
    self.web=[[UIWebView alloc] initWithFrame:self.view.frame];
    self.web.delegate=self;
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.web loadRequest:request];
    self.web.scalesPageToFit=YES;
    [self.view addSubview:self.web];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
}

// 友盟分享
- (void)share{
    // QQ、Qzone title
    [UMSocialData defaultData].extConfig.qqData.title = _model.title;
    [UMSocialData defaultData].extConfig.qzoneData.title = _model.title;
    // QQ、Qzone链接地址
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    // 微信、朋友圈title
    [UMSocialData defaultData].extConfig.wechatSessionData.title = _model.title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = _model.title;
    // 微信、朋友圈链接地址
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57ac3bd3e0f55a4c04002230"
                                      shareText:[NSString stringWithFormat:@"香港远大伟业，成就员工，让客户满意，%@",self.url]
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
}

// 绩效系统说明书
- (void)PSIntroduce{
    LoadResourcesViewController *loadRVC=[[LoadResourcesViewController alloc] init];
    loadRVC.urlString=@"97b4a284a5268ac2de25f0a500551e6c.pdf";
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:loadRVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

#pragma mark--UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_HUD hideAnimated:YES afterDelay:0];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error=%@",error);
    if([error code] == NSURLErrorCancelled)
    {
        return;
    }
//    [_HUD show:YES];
//    _HUD.dimBackground=YES;
    [_HUD hideAnimated:YES afterDelay:0];
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
