//
//  HomePageController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/3/31.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "HomePageController.h"
#import "SendMessageController.h"
#import "CompanyMessageModel.h"
#import "RequestMessageOfCompany.h"
#import "CompanyMessageCell.h"
#import "LoginController.h"
#import "CompanyMessageViewController.h"
#import "RequestLastestNewsData.h"
#import "QuestionnaireWebViewController.h"
#import "BusinessSchoolNewsModel.h"
#import "LastestNewsCell.h"
// 二维码扫描
#import "QRCodeVC.h"
#import "UIViewExt.h"


#import "LGPhoto.h"


#define kScrollNum 11

@interface HomePageController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,LGPhotoPickerBrowserViewControllerDelegate,LGPhotoPickerBrowserViewControllerDataSource>//,MBProgressHUDDelegate>

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,strong) UITableView *lastestNewsTV; // 最新资讯
@property (nonatomic,strong) UIView *bView; // 商学院
@property (nonatomic,strong) UITableView *companyMessageTV; // 公司信息界面

@property (nonatomic,strong) UIView * teacherView;//内训师简介界面



@property (nonatomic,strong) UIAlertController *alert;


@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserPhotoArray;//两个轮播图的数据源
@property (nonatomic, strong)NSMutableArray *LGPhotoPickerBrowserURLArray;
@property (nonatomic, assign) LGShowImageType showType;

//add  by   Allen
@property (nonatomic,strong) UILabel * myLable;
@property (nonatomic,strong) UITableView * myTableView;



// 轮播图
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) UIImageView *imgView;


@property (nonatomic,strong) CompanyMessageModel *model;
// 用户信息
@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,assign) NSInteger is_send_message;
@property (nonatomic,copy) NSMutableArray *array; // message array
@property (nonatomic,copy) NSMutableArray *newsArray; // news array

@property (nonatomic,retain) UISegmentedControl *segment;
@property (nonatomic,retain) UIView *newsView;
@property (nonatomic,retain) UIView *businessView;
@property (nonatomic,retain) UIView *companyView;


@property (nonatomic,assign) NSInteger offSetX;


@end

@implementation HomePageController

static NSString *lastestNewsIdentifier=@"lastestNewsCell";
static NSString *companyNewsIdentifier=@"companyNewsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //检测版本升级
    [self checkVersion];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    _defaults=[NSUserDefaults standardUserDefaults];
    self.is_send_message=[_defaults integerForKey:@"is_send_message"];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫一扫"] style:UIBarButtonItemStyleDone target:self action:@selector(check)];
    self.tabBarController.tabBar.tintColor=[UIColor whiteColor];
    
    [self setTableView];
   
    // 下拉刷新
    [self refreshData];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
    
    self.alert=[UIAlertController alertControllerWithTitle:nil message:@"加载失败，请检查网络！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.alert removeFromParentViewController];
    }];
    [self.alert addAction:sureaction];
}

#pragma mark -  检测版本升级
-(void)checkVersion
{
    NSString *newVersion;
    //https://itunes.apple.com/cn/app/%E8%BF%9C%E5%A4%A7%E5%95%86%E5%AD%A6%E9%99%A2/id1139429427?mt=8
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1139429427"];//这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"通过appStore获取的数据信息：%@",jsonResponseString);
    
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *array = json[@"results"];
    
    for (NSDictionary *dic in array) {
        
        
        newVersion = [dic valueForKey:@"version"];
        
    }
    
    NSLog(@"通过appStore获取的版本号是：%@",newVersion);
    
    //获取本地软件的版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本：%f  %f",[localVersion floatValue],[newVersion floatValue]);
    NSString *msg = [NSString stringWithFormat:@"您当前的版本是V%@，发现新版本V%@，是否下载新版本？",localVersion,newVersion];

    //对比发现的新版本和本地的版本
    if ([newVersion floatValue] > [localVersion floatValue])
    {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"升级提示"message:msg preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"现在升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%BF%9C%E5%A4%A7%E5%95%86%E5%AD%A6%E9%99%A2/id1139429427?mt=8"]];//这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
            NSLog(@"点击现在升级按钮");
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击下次再说按钮");
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// 二维码扫描
- (void)check{
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:[QRCodeVC new] animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)setTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // UISegmentedControl——分段选择控制器
    // 最新资讯
    self.lastestNewsTV=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-149) style:UITableViewStylePlain];
    self.lastestNewsTV.delegate=self;
    self.lastestNewsTV.dataSource=self;
    self.lastestNewsTV.tag=1000;
    self.automaticallyAdjustsScrollViewInsets = NO; // 去除空白部分
    // 在试图出现的时候，需要将第一个视图添加到视图上
    [self.view addSubview:_lastestNewsTV];
//    [self.lastestNewsTV registerClass:[UITableViewCell class] forCellReuseIdentifier:lastestNewsIdentifier];
    [self.lastestNewsTV registerClass:[LastestNewsCell class] forCellReuseIdentifier:lastestNewsIdentifier];
    // 获取数据
    [self getNewsData];
    
    // 商学院
    self.bView=[[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-149)];
    self.bView.hidden=YES;
    [self.view addSubview:self.bView];
    
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-149) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableFooterView = [UIView new];
    [self.bView addSubview:_myTableView];
    
    
    // 轮播图
    [self setCarouselfigure];
    
    // tableView--公司消息
    self.companyMessageTV = [[UITableView alloc] init];
    
    self.teacherView=[[UIView alloc] initWithFrame:CGRectMake(0, 100, kWIDTH, kHEIGHT-153)];
//    self.teacherView.delegate=self;
//    self.teacherView.dataSource=self;
    
    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"001.jpg",
                            @"002.jpg",
                            @"003.jpg",
                            @"004.jpg",
                            @"005.jpg",
                            @"006.jpg",
                            @"007.jpg",
                            @"008.jpg",
                            @"009.jpg",
                            @"0010.jpg",
                            @"0011.jpg",
                            @"0012.jpg",
                            @"0013.jpg",
                            @"0014.jpg",
                            // 本地图片请填写全名
                            ];
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWIDTH , (kWIDTH/720)* 540) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.tag = 10000+2;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.currentPageDotColor = [UIColor orangeColor];//[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
    cycleScrollView.pageDotColor = [UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.center = CGPointMake(_teacherView.frame.size.width/2, _teacherView.frame.size.height/2);
    [self.teacherView addSubview:cycleScrollView];
    
    [self.view addSubview:self.teacherView];
    self.teacherView.hidden=YES;
    self.teacherView.tag=1002;
    // 注册
   // [self.companyMessageTV registerClass:[CompanyMessageCell class] forCellReuseIdentifier:companyNewsIdentifier];
   // [self getData];
    
//    NSArray *array=@[@"商学院新闻",@"商学院简介",@"公司消息"];
     NSArray *array=@[@"商学院新闻",@"商学院简介",@"内训师简介"];
    UISegmentedControl *segment=[[UISegmentedControl alloc] initWithItems:array];
    self.segment=segment;
    segment.frame=CGRectMake(0, 64, kWIDTH, 30);
    segment.tintColor=[UIColor clearColor];
    // 选中字体颜色
    NSDictionary *selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1]};
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    // 未选中字体颜色
    NSDictionary *unselectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    self.newsView=[[UIView alloc] initWithFrame:CGRectMake(5, 32, kWIDTH/3.0-10, 1)];
    self.newsView.backgroundColor=[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
    [segment addSubview:self.newsView];
    segment.selectedSegmentIndex=0;
    // 添加事件
    [segment addTarget:self action:@selector(sel:) forControlEvents:UIControlEventValueChanged];
    // 添加到视图上
    [self.view addSubview:segment];
}

- (void)refreshData{
    self.companyMessageTV.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        [self.companyMessageTV.mj_header endRefreshing];
    }];
}

- (void)getNewsData{
    NSString *encode=[kLASTESTNEWS stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    RequestLastestNewsData *requestLND=[RequestLastestNewsData new];
    [requestLND requestDataWithURL:encode];
    requestLND.managerUI=^(NSMutableArray *dataArray){
        temp.newsArray=dataArray;
        [self.lastestNewsTV reloadData];
        [_HUD hideAnimated:YES afterDelay:0];
        if (dataArray.count==0) {
            [self presentViewController:self.alert animated:YES completion:nil];
        }
    };
}

- (void)getData{
    NSInteger u_id=[_defaults integerForKey:@"u_id"];
    NSString *get_message=[NSString stringWithFormat:@"%@u_id=%ld",kURLOFGET_MESSAGE,(long)u_id];
    NSString *encode=[get_message stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    RequestMessageOfCompany *requestMOC=[RequestMessageOfCompany new];
    [requestMOC requestDataWithURL:encode];
    requestMOC.manager=^(NSMutableArray *dataArray){
        temp.array=dataArray;
        [self.companyMessageTV reloadData];
    };
}


//商学院简介图片轮播图的优化
- (void)setCarouselfigure{
    // scrollView

    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"幻灯片1",
                            @"幻灯片2",
                            @"幻灯片3",
                            @"幻灯片4",
                            @"幻灯片5",
                            @"幻灯片6",
                            @"幻灯片7",
                            @"幻灯片8",
                            @"幻灯片9",
                            @"幻灯片10",
                            @"幻灯片11",
                            // 本地图片请填写全名
                            ];
    // 本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-200) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.tag = 10000+1;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
     cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.currentPageDotColor = [UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
    cycleScrollView.pageDotColor = [UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 3.0;
        self.myTableView.tableHeaderView = cycleScrollView;

    
    
    
    //footerView
    
    
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 300)];
    footerView.tag =  500;
    
    UISegmentedControl * segContr = [[UISegmentedControl alloc] initWithItems:@[@"简介",@"院训",@"校长寄语"]];//[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 30)];
    [segContr addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    segContr.frame = CGRectMake(0, 10, kWIDTH, 30);
    segContr.selectedSegmentIndex = 0;
    [segContr setTintColor:[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1]];
    [footerView addSubview:segContr];
    
    footerView.backgroundColor = [UIColor whiteColor];
    
    
     _myLable =[[UILabel alloc] init];
    
    _myLable.numberOfLines=0;
    _myLable.lineBreakMode = NSLineBreakByWordWrapping;
    _myLable.text=@"        栉风沐雨，风雨同舟，远大集团历经二十多年的发展，已驶入了快速发展的时代。在国家宏观政策调整、市场复杂多变、行业升级的大环境下，走品牌化可持续发展的道路，是集团三五战略规划的重中之重，而人才发展又是实现三五战略的核心和根本。\n         2014年4月26日，远大商学院应势而生，正式挂牌成立，这是远大伟业人才培养的一个重要里程碑。远大商学院担负着集团人才战略规划、人才培养和组织建设工作，关注企业战略、企业商业模式及盈利能力，帮助企业达成绩效目标，助力打造学习型、运动型、健康型的组织。\n        远大商学院的学习培养项目包含雏鹰、飞鹰、雄鹰、特训营、金鹰项目。课程内容包含管理类、网络类、医疗类、职业素养类等全面丰富的课程，每年组织各类培训100余场、为集团的人才和发展提供有力支持！远大商学院已经建立了清晰的人才发展与培养路径图，为集团三五战略规划的实现提供良好的人才保障。";
    _myLable.font = [UIFont systemFontOfSize:17];
    CGSize size = [_myLable sizeThatFits:CGSizeMake(kWIDTH-10, MAXFLOAT)];
    [_myLable setFrame:CGRectMake(5, 50, kWIDTH-10, size.height)];
    footerView.frame = CGRectMake(0,0,kWIDTH,size.height+60);
   // [footerView addSubview:_myLable];
    
   // self.myTableView.tableFooterView = footerView;


}

-(CGFloat)heightForLabel:(NSString *)text{
    CGRect rect = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 85 * kWIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"ArialUnicodeMS" size:17.1]} context:nil];
    return rect.size.height;
}


-(void)change:(UISegmentedControl *)seg{
    [_myLable removeFromSuperview];
    switch (seg.selectedSegmentIndex) {
        case 0:
           
            _myLable.text =@"        栉风沐雨，风雨同舟，远大集团历经二十多年的发展，已驶入了快速发展的时代。在国家宏观政策调整、市场复杂多变、行业升级的大环境下，走品牌化可持续发展的道路，是集团三五战略规划的重中之重，而人才发展又是实现三五战略的核心和根本。\n         2014年4月26日，远大商学院应势而生，正式挂牌成立，这是远大伟业人才培养的一个重要里程碑。远大商学院担负着集团人才战略规划、人才培养和组织建设工作，关注企业战略、企业商业模式及盈利能力，帮助企业达成绩效目标，助力打造学习型、运动型、健康型的组织。\n        远大商学院的学习培养项目包含雏鹰、飞鹰、雄鹰、特训营、金鹰项目。课程内容包含管理类、网络类、医疗类、职业素养类等全面丰富的课程，每年组织各类培训100余场、为集团的人才和发展提供有力支持！远大商学院已经建立了清晰的人才发展与培养路径图，为集团三五战略规划的实现提供良好的人才保障。";
            break;
        case 1:
            _myLable.text = @"        远大商学院是集团战略发展的基石、人才培养的摇篮。远大商学院将能够培养出有真才实干，勇于付出，敢于担当的优秀而卓越的管理精英，提升企业的核心竞争力，真正能让企业的人才梯队发展紧跟日益创新变化的市场需求。";
                       break;
        case 2:
            _myLable.text = @"孝悌忠信礼义廉耻\n孝：孝顺父母\n悌：悌敬  互帮互助\n忠：尽忠\n信：信用\n礼：礼节\n义：义气\n廉：廉洁\n耻：羞耻";
           
            break;
        default:
            break;
    }
    
    CGSize size = [_myLable sizeThatFits:CGSizeMake(kWIDTH-10, MAXFLOAT)];
    [_myLable setFrame:CGRectMake(5, 50, kWIDTH-10, size.height)];
    
    UIView *view1 = [_bView viewWithTag:500];
    [view1 addSubview:_myLable];
    view1.frame = CGRectMake(0,0,kWIDTH,size.height+60);
    [_myTableView reloadData];
}



// 分段选择控制器触发事件
- (void)sel:(UISegmentedControl *)seg{
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.lastestNewsTV.hidden=NO;
            self.bView.hidden=YES;
            if (self.companyMessageTV!=nil) {
                self.companyMessageTV.hidden=YES;
                self.teacherView.hidden = YES;
                self.newsView=[[UIView alloc] initWithFrame:CGRectMake(5, 32, kWIDTH/3.0-10, 1)];
                self.newsView.backgroundColor=[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
                [self.segment addSubview:self.newsView];
            }
            if (self.businessView!=nil) {
                [self.businessView removeFromSuperview];
            }
            if (self.companyView!=nil){
                [self.companyView removeFromSuperview];
            }
            [self.view addSubview:_lastestNewsTV];
            if (self.navigationItem.rightBarButtonItem) {
                self.navigationItem.rightBarButtonItem=nil;
            }
            break;
        case 1:
            self.lastestNewsTV.hidden=YES;
            self.bView.hidden=NO;
            self.teacherView.hidden = YES;
            if (self.companyMessageTV!=nil) {
                self.companyMessageTV.hidden=YES;
                 self.teacherView.hidden = YES;
                self.businessView=[[UIView alloc] initWithFrame:CGRectMake(5+kWIDTH/3.0, 32, kWIDTH/3.0-10, 1)];
                self.businessView.backgroundColor=[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
                [self.segment addSubview:self.businessView];
            }
            if (self.companyView!=nil) {
                [self.companyView removeFromSuperview];
            }
            if (self.newsView!=nil){
                [self.newsView removeFromSuperview];
            }
            if (self.navigationItem.rightBarButtonItem) {
                self.navigationItem.rightBarButtonItem=nil;
            }
            break;
        case 2:
            self.lastestNewsTV.hidden=YES;
            self.companyMessageTV.hidden=YES;
            self.teacherView.hidden = NO;
            self.bView.hidden=YES;
            if (!self.navigationItem.rightBarButtonItem) {
                if (self.is_send_message==1) {
                    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(addMessage:)];
                }
                self.companyView=[[UIView alloc] initWithFrame:CGRectMake(5+kWIDTH/3.0*2, 28, kWIDTH/3.0-10, 1)];
                self.companyView.backgroundColor=[UIColor colorWithRed:27/255.0 green:93/255.0 blue:150/255.0 alpha:1];
                [self.segment addSubview:self.companyView];
            }
            if (self.businessView!=nil) {
                [self.businessView removeFromSuperview];
            }
            if (self.newsView!=nil){
                [self.newsView removeFromSuperview];
            }
            break;
        default:
            break;
    }
}

#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==_companyMessageTV) {
        if (_array.count!=0) {
            return 1;
        }
    }else if (tableView==_lastestNewsTV){
        if (_newsArray.count!=0) {
            return 1;
        }
    }
    return 0;
}

// height of cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_companyMessageTV) {
        return 100;
    }else if (tableView==_lastestNewsTV){
//        return 50;
        return 85;
    }
        return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_companyMessageTV) {
        if (_array.count!=0) {
            return _array.count;
        }
    }else if (tableView==_lastestNewsTV){
        if (_newsArray.count!=0) {
            return _newsArray.count;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_companyMessageTV) {
        CompanyMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:companyNewsIdentifier forIndexPath:indexPath];
        if (_array.count!=0) {
            CompanyMessageModel *model=self.array[indexPath.row];
            cell.titelLabel.text=[NSString stringWithFormat:@"%@",model.title];
            cell.contentlLabel.text=[NSString stringWithFormat:@"%@",model.content];
            cell.add_date.text=model.add_date;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (tableView==_lastestNewsTV){
        LastestNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:lastestNewsIdentifier forIndexPath:indexPath];
        BusinessSchoolNewsModel *model=self.newsArray[indexPath.row];
        NSURL *url=[NSURL URLWithString:[@"http://www.xgyuanda.com" stringByAppendingString:model.litpic]];

       CGFloat  heigth =   [model.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width -115, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height + 5;
        NSLog(@"heigth === %f", heigth);
//        [label.text boundingRectWithSize:CGSizeMake(100, [UIScreen mainScreen].bounds.size.height*10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
        cell.titleLabel.text=model.title;
//        cell.height = heigth;
        [cell.imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        return cell;
    }
    return nil;
}

// 点击cell触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView==_companyMessageTV) {
        CompanyMessageViewController *companyMVC=[[CompanyMessageViewController alloc] init];
        CompanyMessageModel *model=self.array[indexPath.row];
        companyMVC.model=model;
        self.hidesBottomBarWhenPushed=YES; // 隐藏tarBar
        [self.navigationController pushViewController:companyMVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }else if (tableView==_lastestNewsTV){
        QuestionnaireWebViewController *web=[[QuestionnaireWebViewController alloc] init];
        BusinessSchoolNewsModel *model=self.newsArray[indexPath.row];
        web.url=[NSString stringWithFormat:@"%@%@",kLASTESTDETAILNEWS,model.filename];
        web.navTitle=model.title;
        web.model=model;
        web.isHomePage=YES;
        self.hidesBottomBarWhenPushed=YES; // 隐藏tarBar
        [self.navigationController pushViewController:web animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
}

// 发布消息
- (void)addMessage:(UIBarButtonItem *)item{
    // 进行跳转
    SendMessageController *sendMessage=[[SendMessageController alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:sendMessage animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

// lazy load
-(NSMutableArray *)array{
    if (!_array) {
        _array=[NSMutableArray arrayWithCapacity:5];
    }
    return _array;
}

-(NSMutableArray *)newsArray{
    if (!_newsArray) {
        _newsArray=[NSMutableArray arrayWithCapacity:8];
    }
    return _newsArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.segment.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.segment) {
        self.segment.hidden=NO;
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


#pragma mark - 轮播图点击回调
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    self.offSetX = index;
    //NSIndexPath * indexPath = [[NSIndexPath alloc] initWithIndex:index];
    LGPhotoPickerBrowserViewController *BroswerVC = [[LGPhotoPickerBrowserViewController alloc] init];
    BroswerVC.delegate = self;
    BroswerVC.dataSource = self;
   // BroswerVC.currentIndexPath = indexPath;
    BroswerVC.showType = LGShowImageTypeImageBroswer;
    self.showType = LGShowImageTypeImageBroswer;
   
    
    //点击商学院简介
    if(cycleScrollView.tag == 10002){
        self.LGPhotoPickerBrowserPhotoArray = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 14; i++) {
            LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
            photo.photoImage = [UIImage imageNamed:[NSString stringWithFormat:@"00%d.jpg",i]];
            [self.LGPhotoPickerBrowserPhotoArray addObject:photo];
        }
       // NSLog(@"点击商学院简介%ld",index);
        
    }else{//点击内训师简介图片
        self.LGPhotoPickerBrowserPhotoArray = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 11; i++) {
            LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
            photo.photoImage = [UIImage imageNamed:[NSString stringWithFormat:@"幻灯片%d",i]];
            [self.LGPhotoPickerBrowserPhotoArray addObject:photo];
        }
        //NSLog(@"点击内训师简介%ld",index);
    }
    [self presentViewController:BroswerVC animated:YES completion:nil];
    
}
#pragma mark - 轮播图片流浪
- (NSInteger)photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    if (self.showType == LGShowImageTypeImageBroswer) {
    return self.LGPhotoPickerBrowserPhotoArray.count;
} else if (self.showType == LGShowImageTypeImageURL) {
    return self.LGPhotoPickerBrowserURLArray.count;
} else {
   // NSLog(@"非法数据源");
    return 0;
}
}



- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(self.offSetX == ){
//        
//    }
    
    if (self.showType == LGShowImageTypeImageBroswer) {
        return [self.LGPhotoPickerBrowserPhotoArray objectAtIndex:indexPath.item];
    } else if (self.showType == LGShowImageTypeImageURL) {
        return [self.LGPhotoPickerBrowserURLArray objectAtIndex:indexPath.item];
    } else {
       // NSLog(@"非法数据源");
        return nil;
    }
}




@end
