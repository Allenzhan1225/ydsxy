//
//  CheckMealViewController.m
//  远大商学院
//
//  Created by YDWY on 16/8/30.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import "CheckMealViewController.h"
#import "CheckMealModel.h"
#import "LogoutManager.h"
#import "QuestionnaireWebViewController.h"

// 勾餐系统
#define kCHECTMEAL @"http://www.xgyuanda.com/lib/api/exe_get_article?token=sxyapp&list_id=45&field=id,list_name,title,senddate,litpic,description"

@interface CheckMealViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation CheckMealViewController

static NSString *identfier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"勾餐系统";
    self.tableView.tableFooterView=[[UIView alloc] init];
    // 注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identfier];
    // 请求数据
    [self requestData];
}

// 请求数据
- (void)requestData{
    NSString *encode=[kCHECTMEAL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    LogoutManager *manager=[LogoutManager new];
    [manager requestDataWithURL:encode withID:1];
    manager.managerRD=^(NSMutableArray *array){
        temp.dataArray=array;
        [temp.tableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier forIndexPath:indexPath];
    CheckMealModel *model=[CheckMealModel new];
    model=_dataArray[indexPath.row];
    cell.textLabel.text=model.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CheckMealModel *model=[CheckMealModel new];
    model=_dataArray[indexPath.row];
    QuestionnaireWebViewController *web=[QuestionnaireWebViewController new];
    web.navTitle=model.title;
    NSString *string=[model.Description stringByReplacingOccurrencesOfString:@"。" withString:@"."];
    self.hidesBottomBarWhenPushed=YES;
    NSString *string1=[string stringByReplacingOccurrencesOfString:@"：" withString:@":"];
    web.url=[string1 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"+++%@+++%@+++",model.Description,web.url);
    [self.navigationController pushViewController:web animated:YES];
}

// lazy load
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:3];
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
