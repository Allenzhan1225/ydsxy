//
//  MyViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/3/31.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "MyViewController.h"
#import "RecentClassesController.h"
#import "SettingTableViewController.h"
#import "QuestionnaireTableViewController.h"
#import "Exam_recordTableViewController.h"
#import "HistoryAndCollectionViewController.h"
#import "TestViewController.h"
#import "LogoutManager.h"
#import "PersonalInfoViewController.h"
#import "QuestionnaireWebViewController.h"
#import "CheckMealViewController.h"

@interface MyViewController ()

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSArray *imgArray;

@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,strong) NSString *login_name;
@property (nonatomic,strong) NSString *login_password;
@property (nonatomic,assign) NSInteger u_id;
@property (nonatomic,assign) NSInteger r_id;

@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) UIAlertController *alert;

// 个人头像信息
@property (nonatomic,retain) UIImageView *backImgView;
@property (nonatomic,retain) UIImageView *imgView;

@end

@implementation MyViewController

static NSString *CellIdentifier=@"reuseIdentifier";


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    // 设置个人信息
    [self setHeaderImg];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Setting"] style:UIBarButtonItemStyleDone target:self action:@selector(clickSetting)];
//    self.array=@[@"最近课程",@"在线考试",@"问卷调查",@"考试记录",@"历史及收藏",@"绩效系统",@"勾餐系统",@"人才招聘",@"DISC性格测试",@"退出登录"];
    self.array=@[@"最近课程",@"在线考试",@"问卷调查",@"考试记录",@"历史及收藏",@"DISC性格测试",@"退出登录"];
    //self.imgArray=@[@"The recent course",@"The online test",@"The questionnaire survey",@"Test records",@"collection",@"performance",@"can",@"recruitment",@"dis",@"exit"];
    self.imgArray=@[@"The recent course",@"The online test",@"The questionnaire survey",@"Test records",@"collection",@"dis",@"exit"];
    
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // 代理和数据源
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.tableView.tableFooterView=[[UIView alloc] init];
}

// 设置个人信息
- (void)setHeaderImg{
    // 背景
    self.backImgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HeaderImg"]];
    self.backImgView.frame=CGRectMake(0, 0, kWIDTH, kHEIGHT/4.0);
    // 个人图像
    self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH/2.0-kHEIGHT/32.0*3, kHEIGHT/64.0, kHEIGHT/16.0*3, kHEIGHT/16.0*3)];
    NSString *imgName=[_defaults valueForKey:@"imgName"];
    if ([imgName isEqual:@""] || imgName==nil) {
        self.imgView.image=[UIImage imageNamed:@"logo"];
    }else{
        // 读取图片
        NSString *path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName];
        UIImage *img=[[UIImage alloc] initWithContentsOfFile:path];
        self.imgView.image=img;
    }
    // 圆角
    self.imgView.layer.masksToBounds=YES;
    self.imgView.layer.cornerRadius=kHEIGHT/32.0*3;
    // 交互
    self.imgView.userInteractionEnabled=YES;
    // 添加手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imgView addGestureRecognizer:tap];
    // 交互必开（否则没有效果）
    self.backImgView.userInteractionEnabled=YES;
    [self.backImgView addSubview:self.imgView];
    // nickName
    UILabel *nickName=[[UILabel alloc] initWithFrame:CGRectMake(kWIDTH/2.0-100, kHEIGHT/64.0*13, 200, kHEIGHT/64.0*3)];
    // 获取昵称
    NSString *nick=[_defaults valueForKey:@"nickName"];
    if ([nick isEqual:@""] || nick==nil) {
        nickName.text=@"请点击头像修改资料";
    }else{
        nickName.text=nick;
    }
    nickName.textColor=[UIColor whiteColor];
//    NSLog(@"length=%lu",[nickName.text length]);
    nickName.textAlignment=NSTextAlignmentCenter;
    nickName.font=[UIFont systemFontOfSize:20];
    [self.backImgView addSubview:nickName];
    self.tableView.tableHeaderView=self.backImgView;
    
}

//设置
- (void)clickSetting{
    SettingTableViewController *settinfTVC=[[SettingTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:settinfTVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

// 手势-- 跳转个人设置界面
- (void)tap:(UITapGestureRecognizer *)tap{
    PersonalInfoViewController *personalIVC=[[PersonalInfoViewController alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:personalIVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.array.count!=0) {
        return self.array.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=self.array[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:self.imgArray[indexPath.row]];
//    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

// 点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row!=9) {
        [self pushViewWithnumb:indexPath.row];
    }else{
        // 退出登录
//        [self requestLogoutWithUrl];
        [self requestUrlWithID:0];
    }
}

- (void)logOut{
    if ([self.message isEqualToString:@""] || self.message==nil) {
    }else if ([self.message isEqualToString:@"该用户未登陆！"] || [self.message isEqualToString:@"退出成功！"] || [self.message isEqualToString:@"该用户不存在"]){
        self.alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:self.message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction  *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self presentVC];
            [self.alert removeFromParentViewController];
        }];
        [self.alert addAction:sureAction];
        // alertController 显示
        [self presentViewController:self.alert animated:YES completion:nil];
    }
}

- (void)presentVC{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *login=[sb instantiateViewControllerWithIdentifier:@"LoginController"];
//    login.navigationController.toolbarHidden=YES;
    [self presentViewController:login animated:YES completion:nil];
}

//- (void)requestLogoutWithUrl{
//    _u_id=[_defaults integerForKey:@"u_id"];
//    NSString *stringOfLogout=[NSString stringWithFormat:@"%@u_id=%ld",kURLOFUSERLOGOUT,(long)_u_id];
////    NSLog(@"stringOfLogout====%@",stringOfLogout);
//    NSString *encode=[stringOfLogout stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    __weak typeof (self)temp=self;
//    LogoutManager *logout=[LogoutManager new];
//    [logout requestDataWithURL:encode];
//    logout.manager=^(NSString *string){
//        temp.message=string;
////        NSLog(@"%@",temp.message);
//        [temp.tableView reloadData];
//        [temp logOut];
//    };
//}

// 0 退出登录；1 勾餐请求
- (void)requestUrlWithID:(int)ID{
    _u_id=[_defaults integerForKey:@"u_id"];
    NSString *stringOfLogout=[NSString stringWithFormat:@"%@u_id=%ld",kURLOFUSERLOGOUT,(long)_u_id];
    //    NSLog(@"stringOfLogout====%@",stringOfLogout);
    NSString *encode=[stringOfLogout stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    LogoutManager *logout=[LogoutManager new];
    [logout requestDataWithURL:encode withID:ID];
    logout.manager=^(NSString *string){
        temp.message=string;
        //        NSLog(@"%@",temp.message);
        [self.tableView reloadData];
        [self logOut];
    };
}

- (void)pushViewWithnumb:(NSInteger)numb{
    switch (numb) {
        case 0:{ // 最近课程
            RecentClassesController *recent=[[RecentClassesController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:recent animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 1:{ // 在线考试
            TestViewController *test=[[TestViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:test animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 2:{ // 问卷调查
            QuestionnaireTableViewController *questionnaire=[[QuestionnaireTableViewController alloc] init];
            questionnaire.titleName=self.array[numb];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:questionnaire animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 3:{ // 考试记录
            Exam_recordTableViewController *exam=[[Exam_recordTableViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:exam animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 4:{ // 历史及收藏
            HistoryAndCollectionViewController *history=[[HistoryAndCollectionViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:history animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 5:{ // 绩效系统
            QuestionnaireWebViewController *performanceSystemVC=[[QuestionnaireWebViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            performanceSystemVC.url=kPERFORMANCESYSTEMURL;
            performanceSystemVC.navTitle=@"绩效系统";
            performanceSystemVC.isPerformSystem=YES;
            [self.navigationController pushViewController:performanceSystemVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 6:{ // 勾餐系统
            CheckMealViewController *check=[[CheckMealViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
//            performanceSystemVC.url=kCHECTMEAL;
            [self.navigationController pushViewController:check animated:YES];
            self.hidesBottomBarWhenPushed=NO;;
        }
            break;
        case 7:{ // 人才招聘
            QuestionnaireWebViewController *performanceSystemVC=[[QuestionnaireWebViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            performanceSystemVC.url=kRECRUIT;
            performanceSystemVC.navTitle=@"人才招聘";
            [self.navigationController pushViewController:performanceSystemVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        case 8:{ // DISC性格测试
            QuestionnaireWebViewController *discVC=[[QuestionnaireWebViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            _u_id=[_defaults integerForKey:@"u_id"];
            discVC.url=[NSString stringWithFormat:@"%@%ld",kDISC,(long)_u_id];
            NSLog(@"%@",[NSString stringWithFormat:@"%@%ld",kDISC,(long)_u_id]);
            discVC.navTitle=@"DISC性格测试";
            [self.navigationController pushViewController:discVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
            break;
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
