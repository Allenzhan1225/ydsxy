//
//  RecentClassesController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "RecentClassesController.h"
#import "RecentClassDetailManager.h"
#import "CoursesModel.h"
#import "RecentClassTableViewCell.h"
#import "RecentClassPlanTableViewCell.h"
#import "ClassDetailViewController.h"

#define kRECENTCLASSPICURL @"peixun.xgyuanda.com/Public/uploads/course/middle_"

@interface RecentClassesController ()

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,copy) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *timeString;
@property (nonatomic,strong) NSString *enrollStr; // 报名返回信息

@property (nonatomic,assign) NSInteger u_id;

@property (nonatomic,strong) UIAlertController *alert;

@end

@implementation RecentClassesController

static NSString *reuseIdetifier=@"cell";
static NSString *planReuseIdetifier=@"planCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"最近课程";
    _defaults=[NSUserDefaults standardUserDefaults];
    
//    [self refreshData];
    [self requestDataWithBOLL:NO withClassID:0];
    
    // 注册
    [self.tableView registerClass:[RecentClassTableViewCell class] forCellReuseIdentifier:reuseIdetifier];
    [self.tableView registerClass:[RecentClassPlanTableViewCell class] forCellReuseIdentifier:planReuseIdetifier];
    
    self.alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [self.alert addAction:sureAction];
    
    [self refreshData];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
}

- (void)refreshData{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataWithBOLL:NO withClassID:0];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)requestDataWithBOLL:(BOOL)isOrNo withClassID:(int)id{
    _u_id=[_defaults integerForKey:@"u_id"];
    if (isOrNo==NO) { // 加载课程资源
        NSString *course=[NSString stringWithFormat:@"%@u_id=%ld",kCOURSELIST,(long)_u_id];

        NSString *encode=[course stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        RecentClassDetailManager *recentClass=[RecentClassDetailManager new];
        [recentClass requestDataWithURL:encode clickIsOrNo:isOrNo];
        __weak typeof (self)temp=self;
        recentClass.manager=^(NSMutableArray *array,NSString *string){
            temp.dataArray=array;
            temp.timeString=string;
            [temp.tableView reloadData];
            [_HUD hideAnimated:YES afterDelay:0];
        };
    }else if (isOrNo==YES){ // 报名请求
        NSString *course=[NSString stringWithFormat:@"%@u_id=%ld&id=%d",kCOURSE_ENROLL,(long)_u_id,id];
        NSString *encode=[course stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        RecentClassDetailManager *recentClass=[RecentClassDetailManager new];
        [recentClass requestDataWithURL:encode clickIsOrNo:isOrNo];
        __weak typeof (self)temp=self;
        recentClass.enroll=^(NSString *string){
            temp.enrollStr=string;
            self.alert.message=string;
            [self presentViewController:self.alert animated:YES completion:nil];
            [temp requestDataWithBOLL:NO withClassID:0];
            [temp.tableView reloadData];
        };
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_dataArray.count!=0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count!=0) {
        return _dataArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count!=0) {
        return 110;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CoursesModel *model=self.dataArray[indexPath.row];
    if (model.c_type_1==1) {
        RecentClassTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseIdetifier];
        [cell.picImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCOURCESIMGURL,model.pic]]];
        cell.name.text=model.name;
        cell.docent_name.text=model.docent_name;
        if (model.status==0) {
            BOOL outDate=[self dateChangeStampWith:self.timeString withs_date:model.s_date];
            if (outDate==YES) {
                if (cell || cell.btn.currentTitle==nil || [cell.btn.currentTitle isEqual:@""]) {
                    cell=[[RecentClassTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdetifier];
                    [cell.btn setTitle:@"报名" forState:UIControlStateNormal];
                    cell.btn.backgroundColor=[UIColor orangeColor];
                    
                    [cell.picImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCOURCESIMGURL,model.pic]]];
                    cell.name.text=model.name;
                    cell.docent_name.text=model.docent_name;
                }
                // 点击事件
                cell.btn.tag=model.id+10000;
                [cell.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            }else{
                [cell.btn setTitle:@"已结束" forState:UIControlStateNormal];
                cell.btn.backgroundColor=[UIColor lightGrayColor];
                cell.btn.userInteractionEnabled=NO;
                cell.btn.alpha=0.3;
            }
        }else if (model.status==1){
            //            NSLog(@"已报名!");
            [cell.btn setTitle:@"已报名" forState:UIControlStateNormal];
            cell.btn.userInteractionEnabled=NO;
            cell.btn.backgroundColor=[UIColor lightGrayColor];
            cell.btn.alpha=0.4;
        }
        
        int l = [self countChar:model.obj_id cChar:','];
        cell.obj_id.text=[NSString stringWithFormat:@"%d",l];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else if (model.c_type_1==2){
        RecentClassPlanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:planReuseIdetifier];
        [cell.picImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCOURCESIMGURL,model.pic]]];
        cell.name.text=model.name;
        cell.docent_name.text=model.docent_name;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

// 日期转时间戳
- (BOOL)dateChangeStampWith:(NSString *)stamp withs_date:(NSString *)s_date{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *date=[formatter dateFromString:s_date];
    NSString *time=[NSString stringWithFormat:@"%.f",[date timeIntervalSince1970]];
//    NSLog(@"%d---%d",[stamp intValue],[time intValue]);
    if ([stamp intValue]>[time intValue] || [stamp intValue]==[time intValue]) {
        return NO;
    }else{
        return YES;
    }
}

// 计算字符串中字符个数
- (int)countChar:(NSString *)string cChar:(char)c{
    int count=0;
    NSInteger l=[string length];
    for (int i=0; i<l; i++) {
        char cc=[string characterAtIndex:i];
        if (cc==c) {
            count++;
        }
    }
    return count;
}

- (void)click:(UIButton *)btn{
    int id=(int)btn.tag-10000;
    [self requestDataWithBOLL:YES withClassID:id];
}

// 课程详情查看
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CoursesModel *model=self.dataArray[indexPath.row];
    ClassDetailViewController *classDVC=[[ClassDetailViewController alloc] init];
    classDVC.model=model;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:classDVC animated:YES];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:7];
    }
    return _dataArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.alert removeFromParentViewController];
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
