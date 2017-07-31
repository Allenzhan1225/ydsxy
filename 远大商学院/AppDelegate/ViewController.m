//
//  ViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/3/30.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ViewController.h"
#import "LoginController.h"

// 引导图片数
#define kIMGCOUNT 4

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIPageControl *page;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    NSLog(@"i came here!");
    
    [self buildUI];  // 解析：parse
}

- (void)buildUI{
    /*
     *创建并添加UIScrollView
     */
    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT)];
//    _scroll.pagingEnabled=YES;
    _scroll.backgroundColor=[UIColor redColor];
    [self.view addSubview:_scroll];
    
    /**
     *  scrollView设置
     */
    _scroll.contentSize=CGSizeMake(kWIDTH*kIMGCOUNT, kHEIGHT);
    _scroll.showsVerticalScrollIndicator=NO;
    _scroll.showsHorizontalScrollIndicator=NO;
    _scroll.bounces=NO;
    _scroll.pagingEnabled=YES;
    _scroll.delegate=self;
    
    /*
     *  创建并添加图片
     */
    for (int i=0; i<kIMGCOUNT; i++) {
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH*i, 0, kWIDTH, kHEIGHT)];
        imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"引导-%d",i+1]];
        [_scroll addSubview:imgView];
        if (i==kIMGCOUNT-1) {
            // 最后一张需要添加点击事件
            [self setupLastImageView:imgView];
        }
    }
    
    /*
     *  创建并添加pageControl
     */
    _page=[[UIPageControl alloc] initWithFrame:CGRectMake(0, kHEIGHT/9*8, kWIDTH, 30)];
    _page.numberOfPages=kIMGCOUNT;
    _page.pageIndicatorTintColor=[UIColor redColor];
    _page.currentPageIndicatorTintColor=[UIColor blueColor];
//    [self.view addSubview:_page];
}

#pragma mark--UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset=scrollView.contentOffset;
    CGFloat offsetX=offset.x;
    int pageNum=(offsetX+0.5*_scroll.frame.size.width)/_scroll.frame.size.width;
    _page.currentPage=pageNum;
}

// UIImageView默认交互功能关闭
- (void)setupLastImageView:(UIImageView *)imgView{
    imgView.userInteractionEnabled=YES;
    
    UIImageView *startImg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"开始体验"]];
    startImg.frame=CGRectMake((kWIDTH-250)/2.0, kHEIGHT/5*4, 250, 60);
    startImg.userInteractionEnabled=YES;
    [imgView addSubview:startImg];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [startImg addGestureRecognizer:tap];
}

// 点击事件，跳转到登陆界面
- (void)tap{
    LoginController *login=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginController"];
    [self presentViewController:login animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
