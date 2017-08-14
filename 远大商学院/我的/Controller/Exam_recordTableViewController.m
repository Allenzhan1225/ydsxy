//
//  Exam_recordTableViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "Exam_recordTableViewController.h"
#import "Exam_recordManager.h"
#import "Exam_recordModel.h"
#import "Exam_recordDetailViewController.h"

@interface Exam_recordTableViewController ()

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,strong) UIAlertController *alert;
@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger u_id;

@end

@implementation Exam_recordTableViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"考试记录";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    self.tableView.tableFooterView = [UIView new];
    [self requestData];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
    
    self.alert=[UIAlertController alertControllerWithTitle:nil message:@"暂无任何考试记录！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureaction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.alert removeFromParentViewController];
    }];
    [self.alert addAction:sureaction];
}

- (void)requestData{
    _u_id=[_defaults integerForKey:@"u_id"];
    NSString *exam=[NSString stringWithFormat:@"%@u_id=%ld",kEXAM_RECORD,(long)_u_id];
    NSString *encode=[exam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    Exam_recordManager *examManger=[Exam_recordManager new];
    [examManger requestDataWithURL:encode];
    __weak typeof (self)temp=self;
    examManger.manager=^(NSMutableArray *array){
        temp.dataArray=array;
        [temp.tableView reloadData];
        [_HUD hideAnimated:YES afterDelay:0];
        if (array.count==0) {
            [self presentViewController:self.alert animated:YES completion:nil];
        }
    };
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Exam_recordModel *model=_dataArray[indexPath.row];
    cell.textLabel.text=model.t_p_name;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:8];
    }
    return _dataArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Exam_recordModel *model=_dataArray[indexPath.row];
    NSString *str=[NSString stringWithFormat:@"%@u_id=%ld&id=%d",kVIEW_EXAM_RECORD,(long)_u_id,model.id];
//    NSLog(@"str=%@",str);
    Exam_recordDetailViewController *detailVC=[[Exam_recordDetailViewController alloc] init];
    detailVC.loadURL=str;
    detailVC.titleName=model.t_p_name;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
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
