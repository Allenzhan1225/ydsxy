//
//  ResourcesViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/3/31.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ResourcesViewController.h"
#import "ResourceTableViewCell.h"
#import "ResourcesModel.h"
#import "C_one_listViewController.h"
#import "ResourceManager.h"

@interface ResourcesViewController ()

// 数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSString *stringURL;

@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,assign) NSInteger u_id;

@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation ResourcesViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:22]}];
    // 注册
    [self.tableView registerClass:[ResourceTableViewCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    // 请求数据
    [self requestData];
    

    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [self.view addSubview:_HUD];
}

// 请求数据
- (void)requestData{
    _defaults=[NSUserDefaults standardUserDefaults];
    _u_id=[_defaults integerForKey:@"u_id"];
    NSString *resources=[NSString stringWithFormat:@"%@u_id=%ld",kURLOFRESOURCES,(long)_u_id];
    self.stringURL=resources;
//    NSLog(@"resources=%@",resources);
    NSString *encode=[resources stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak typeof (self)temp=self;
    ResourceManager *detail=[ResourceManager new];
    [detail requestDataWithURL:encode];
    detail.manager=^(NSMutableArray *array){
        temp.dataArray=array;
        [self.tableView reloadData];
        [_HUD hideAnimated:YES afterDelay:0];
    };
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
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
    if (self.dataArray.count!=0) {
        return self.dataArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResourceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    ResourcesModel *model=_dataArray[indexPath.row];
    cell.kinds.text=model.name;
    cell.numb.text=[NSString stringWithFormat:@"%d",model.click];
    cell.imgView.image=[UIImage imageNamed:model.pic];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

// cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

// cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    C_one_listViewController *c_one_listVC=[C_one_listViewController new];
    ResourcesModel *model=_dataArray[indexPath.row];
    NSString *string=[NSString stringWithFormat:@"%@&c_one_id=%d",self.stringURL,model.id];
    c_one_listVC.string=string;
    c_one_listVC.name=model.name;
    c_one_listVC.id=model.id;
    c_one_listVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:c_one_listVC animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
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
