//
//  C_two_listTableViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/7.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "C_two_listTableViewController.h"
#import "ListDetailManager.h"
#import "C_two_lsitModel.h"
#import "C_two_lisTableViewCell.h"
#import "LoadResourcesViewController.h"

@interface C_two_listTableViewController ()

@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger c_two_id;
@property (nonatomic,retain) MBProgressHUD *HUD;

@end

@implementation C_two_listTableViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.tableView registerClass:[C_two_lisTableViewCell class] forCellReuseIdentifier:identifier];
    [self requestData];
    
    _HUD=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.label.text=@"正在加载中···";
    [_HUD showAnimated:YES];
}


- (void)requestData{
    NSString *encode=[self.stringUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    ListDetailManager *detail=[ListDetailManager new];
    [detail requestDataWithURL:encode];
    __weak typeof (self)temp=self;
    detail.manager=^(NSMutableArray *array){
        if (array.count==0) {
//            UILabel *label=[[UILabel alloc] initWithFrame:self.view.frame];
//            label.text=@"暂无任何数据";
//            label.textAlignment=NSTextAlignmentCenter;
//            [self.tableView addSubview:label];
            self.tableView.tableFooterView = [UIView new];
            UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200 , 200 )];
            CGPoint center = CGPointMake(self.view.center.x, self.view.center.y - 40);
            imgView.center = center;
            imgView.image = [UIImage imageNamed:@"prompt1.png"];
            [self.tableView addSubview:imgView];
        }else{
              self.tableView.tableFooterView = [UIView new];
            temp.dataArray=array;
            [temp.tableView reloadData];
        }
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
    C_two_lisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    C_two_lsitModel *model=self.dataArray[indexPath.row];
//    cell.textLabel.text=model.title;
    cell.title.text=model.title;
    cell.num.text=[NSString stringWithFormat:@"%ld",(long)model.num];
    cell.date.text=model.date;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRESOURCESIMGURL,model.pic]];
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k1,model.pic]];
//    NSLog(@"url=%@",url);
    [cell.imgView sd_setImageWithURL:url];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    C_two_lsitModel *model=self.dataArray[indexPath.row];
    LoadResourcesViewController *loadRVC=[[LoadResourcesViewController alloc] init];
    loadRVC.urlString=model.name;
    loadRVC.navTitle=model.title;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:loadRVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
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
