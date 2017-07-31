//
//  TestSearchViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/17.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "TestSearchViewController.h"
#import "TestTableViewCell.h"
#import "TestModel.h"
#import "Exam_recordDetailViewController.h"
#import "TestManager.h"

@interface TestSearchViewController ()<UISearchBarDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,retain) UISearchBar *searchBar;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain) NSUserDefaults *defaults;
@property (nonatomic,assign) NSInteger u_id;

@property (nonatomic,retain) UIAlertController *alert;
@property (nonatomic,retain) UIPickerView *picker;
@property (nonatomic,retain) NSArray *pickerArray;
@property (nonatomic,retain) UIView *headView;
@property (nonatomic,retain) NSString *test;

@end

@implementation TestSearchViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    // 设置头视图
    [self setupHeadView];
    
    [self.tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)setupHeadView{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 95)];
    self.headView=view;
    view.backgroundColor=[UIColor whiteColor];
    self.tableView.tableHeaderView=view;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(kWIDTH/4.0, 5, 50, 44)];
    label.text=@"部门:";
    label.font=[UIFont systemFontOfSize:20];
    [view addSubview:label];
    // picker
    self.pickerArray=@[@"请选择部门",@"人资",@"培训",@"行政",@"市场",@"企划",@"医生",@"护理",@"客服",@"财务",@"采购",@"网络-制作",@"网络-运营",@"网络-竞价",@"网络-咨询",@"网络-微营销"];
    self.picker=[[UIPickerView alloc] initWithFrame:CGRectMake(kWIDTH/4.0+50, 5, kWIDTH/30.0*11, 44)];
    self.picker.delegate=self;
    self.picker.dataSource=self;
    [view addSubview:self.picker];
    
    // 搜索框设置
    [self setSearchBar];
}

// 搜索框设置
- (void)setSearchBar{
    self.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(5, 50, kWIDTH-10, 40)];
    self.searchBar.delegate=self;
    self.searchBar.placeholder=@"请输入想搜索的内容";
    self.searchBar.barTintColor=[UIColor whiteColor];
//    [self.navigationController.navigationBar addSubview:self.searchBar];
    [self.headView addSubview:self.searchBar];
}

#pragma mark--UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //    NSLog(@"%@222",_searchBar.text);
    if (self.dataArray.count!=0) {
        self.dataArray=nil;
    }
    [self getData];
    [self.searchBar resignFirstResponder];
}

//  解析数据
- (void)getData{
    _u_id=[_defaults integerForKey:@"u_id"];
    NSInteger d_id=[self.picker selectedRowInComponent:0];
//    NSString *test=[NSString stringWithFormat:@"%@u_id=%ld",kTESTLIST,(long)_u_id];
    if (d_id==1) {
        NSString *test=[NSString stringWithFormat:@"%@%ld&name=%@",kTESTSEARCH,(long)_u_id,self.searchBar.text];
        self.test=test;
    }else{
        NSString *test=[NSString stringWithFormat:@"%@%ld&d_id=%ld&name=%@",kTESTSEARCH,(long)_u_id,(long)d_id,self.searchBar.text];
        self.test=test;
    }
    NSString *encode=[_test stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    TestManager *tManager=[TestManager new];
    [tManager requestDataWithURL:encode withType:1];
    __weak typeof (self)temp=self;
    tManager.manager=^(NSMutableArray *array,int u_id){
        temp.dataArray=array;
        [self getDataMessage];
        [temp.tableView reloadData];
    };
}

-(void)getDataMessage{
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.alert removeFromParentViewController];
    }];
    if (self.dataArray.count==0) {
        self.alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"暂时没有符合要求的数据···" preferredStyle:UIAlertControllerStyleAlert];
    }else{
        self.alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"找到%lu条符合要求的数据",(unsigned long)self.dataArray.count] preferredStyle:UIAlertControllerStyleAlert];
    }
    [self.alert addAction:sureAction];
    [self presentViewController:self.alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--UIPickerViewDelegate,UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerArray[row];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataArray.count!=0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count!=0) {
        return self.dataArray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    TestModel *model=_dataArray[indexPath.row];
    cell.name.text=model.name;
    cell.department.text=[NSString stringWithFormat:@"部门:%@",[self stringByD_id:model.d_id]];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kTEST_PAPER,model.pic]]];
    return cell;
}

- (NSString *)stringByD_id:(int)d_id{
    switch (d_id) {
        case 1:
            return @"请选择部门";
            break;
        case 2:
            return @"人资";
            break;
        case 3:
            return @"培训";
            break;
        case 4:
            return @"行政";
            break;
        case 5:
            return @"市场";
            break;
        case 6:
            return @"企划";
            break;
        case 7:
            return @"医生";
            break;
        case 8:
            return @"护理";
            break;
        case 9:
            return @"客服";
            break;
        case 10:
            return @"财务";
            break;
        case 11:
            return @"采购";
            break;
        case 12:
            return @"网络-制作";
            break;
        case 13:
            return @"网络-运营";
            break;
        case 14:
            return @"网络-竞价";
            break;
        case 15:
            return @"网络-咨询";
            break;
        case 16:
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
    testWebVC.loadURL=[NSString stringWithFormat:@"%@u_id=%ld&id=%d",kTESTWEBURL,(long)_u_id,model.id];
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
