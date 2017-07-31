//
//  QuestionnaireTableViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/28.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "QuestionnaireTableViewController.h"
#import "QuestionnaireManager.h"
#import "QuestionnaireModel.h"
#import "QuestionnaireTableViewCell.h"
#import "QuestionnaireDetailViewController.h"
#import "QuestionnaireWebViewController.h"

@interface QuestionnaireTableViewController ()

@property (nonatomic,retain) MBProgressHUD *HUD;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,assign) NSUInteger u_id;

@end

@implementation QuestionnaireTableViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=self.titleName;
    _defaults=[NSUserDefaults standardUserDefaults];
    
    [self.tableView registerClass:[QuestionnaireTableViewCell class] forCellReuseIdentifier:identifier];
    
    [self requestData];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
}

- (void)requestData{
    _u_id=[_defaults integerForKey:@"u_id"];
    NSString *urlStr=[NSString stringWithFormat:@"%@u_id=%ld",kQUESTIONLIST,(unsigned long)_u_id];
    NSString *encode=[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    QuestionnaireManager *managerQ=[QuestionnaireManager new];
    [managerQ requestDataWithURL:encode];
    __weak typeof (self)temp=self;
    managerQ.manager=^(NSMutableArray *array){
        temp.dataArray=array;
//        NSLog(@"array=%@",_dataArray);
        [self.tableView reloadData];
        [_HUD hideAnimated:YES afterDelay:0];
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
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count!=0) {
        return _dataArray.count;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionnaireTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    QuestionnaireModel *model=self.dataArray[indexPath.row];
    cell.titleLabel.text=model.name;
    [cell.attendBtn addTarget:self action:@selector(attend:) forControlEvents:UIControlEventTouchUpInside];
    cell.attendBtn.tag=1000+indexPath.row;
    [cell.detailBtn addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    cell.detailBtn.tag=10000+indexPath.row;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)attend:(UIButton *)sender{
    QuestionnaireModel *model=self.dataArray[sender.tag-1000];
    QuestionnaireWebViewController *webVC=[[QuestionnaireWebViewController alloc] init];
    NSString  *url=[NSString stringWithFormat:@"%@u_id=%ld&id=%d",kQUESTIONWEBURL,(unsigned long)_u_id,model.id];
    webVC.url=url;
    webVC.navTitle=model.name;
    webVC.isHomePage=NO;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)detail:(UIButton *)sender{
    QuestionnaireModel *model=self.dataArray[sender.tag-10000];
    QuestionnaireDetailViewController *questionnaireDVC=[[QuestionnaireDetailViewController alloc] init];
    questionnaireDVC.model=model;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:questionnaireDVC animated:YES];
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
