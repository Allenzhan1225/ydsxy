//
//  TestDetailTableViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/4.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "TestDetailTableViewController.h"
#import "TestManager.h"
#import "TestModel.h"
#import "Exam_recordDetailViewController.h"
#import "TestTableViewCell.h"

@interface TestDetailTableViewController ()//<MBProgressHUDDelegate>

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,retain) NSUserDefaults *defaults;
@property (nonatomic,assign) NSInteger u_id;
@property (nonatomic,retain) NSMutableArray *dataArray;

@end

@implementation TestDetailTableViewController

static NSString *identifiier=@"cell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    // 解析数据
    [self requestData];
    
//    _HUD=[[MBProgressHUD alloc] initWithView:self.view];
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _HUD.delegate=self;
    _HUD.label.text=@"正在加载中···";
//    [self.view addSubview:_HUD];
//    [_HUD show:YES];
    [_HUD showAnimated:YES];
//    _HUD.dimBackground=YES;
}

- (void)requestData{
    _u_id=[_defaults integerForKey:@"u_id"];
    NSString *test=[NSString stringWithFormat:@"%@u_id=%ld&d_id=%ld",kTESTLIST,(long)_u_id,(long)(_index+1)];
    NSString *encode=[test stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    TestManager *tManager=[TestManager new];
    [tManager requestDataWithURL:encode withType:0];
    __weak typeof (self)temp=self;
    tManager.manager=^(NSMutableArray *array,int u_id){
        // index+1=u_id；index是从0开始的，u_id是从1开始的
        if (temp.index==u_id-1) {
            temp.dataArray=array;
            temp.u_id=u_id;
            [temp.tableView reloadData];
//            [_HUD hide:YES afterDelay:0];
            [_HUD hideAnimated:YES afterDelay:0];
//            _HUD.dimBackground=NO;
        }
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:identifiier];
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiier forIndexPath:indexPath];
    TestModel *model=_dataArray[indexPath.row];
    cell.name.text=model.name;
    cell.department.text=[NSString stringWithFormat:@"部门:%@",[self stringByD_id:model.d_id]];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kTEST_PAPER,model.pic]]];
    return cell;
}

- (NSString *)stringByD_id:(int)d_id{
    switch (d_id) {
        case 1:
            return @"人资";
            break;
        case 2:
            return @"培训";
            break;
        case 3:
            return @"行政";
            break;
        case 4:
            return @"市场";
            break;
        case 5:
            return @"企划";
            break;
        case 6:
            return @"医生";
            break;
        case 7:
            return @"护理";
            break;
        case 8:
            return @"客服";
            break;
        case 9:
            return @"财务";
            break;
        case 10:
            return @"采购";
            break;
        case 11:
            return @"网络-制作";
            break;
        case 12:
            return @"网络-运营";
            break;
        case 13:
            return @"网络-竞价";
            break;
        case 14:
            return @"网络-咨询";
            break;
        case 15:
            return @"网络-微营销";
            break;
        default:
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //  共用webView
    Exam_recordDetailViewController *testWebVC=[[Exam_recordDetailViewController alloc] init];
    TestModel *model=_dataArray[indexPath.row];
    testWebVC.titleName=model.name;
    testWebVC.loadURL=[NSString stringWithFormat:@"%@u_id=%ld&id=%d",kTESTWEBURL,(long)[_defaults integerForKey:@"u_id"],model.id];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:testWebVC animated:YES];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:8];
    }
    return _dataArray;
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
