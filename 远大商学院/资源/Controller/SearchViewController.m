//
//  SearchViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/16.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "SearchViewController.h"
#import "LoadResourcesViewController.h"
#import "ListDetailManager.h"
#import "C_two_lisTableViewCell.h"
#import "C_two_lsitModel.h"

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,retain) UISearchBar *searchBar;
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain) NSUserDefaults *defaults;

@property (nonatomic,retain) UIAlertController *alert;

@end

@implementation SearchViewController

static NSString *identifier=@"cell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 搜索框设置
    [self setSearchBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaults=[NSUserDefaults standardUserDefaults];
    
    [self.tableView registerClass:[C_two_lisTableViewCell class] forCellReuseIdentifier:identifier];
}

// 搜索框设置
- (void)setSearchBar{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(kWIDTH/4, 5, kWIDTH*18/30, 30)];
    self.searchBar.delegate=self;
    self.searchBar.placeholder=@"请输入想搜索的内容";
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar addSubview:self.searchBar];
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

- (void)search{
//    NSLog(@"%@111",_searchBar.text);
    if (self.dataArray.count!=0) {
        self.dataArray=nil;
    }
    [self getData];
    [self.searchBar resignFirstResponder];
}

//  解析数据
- (void)getData{
    NSInteger u_id=[_defaults integerForKey:@"u_id"];
    int c_one_id=self.id;
    NSString *string=[NSString stringWithFormat:@"%@u_id=%ld&c_one_id=%d&title=%@",kRESOURCESSEARCH,(long)u_id,c_one_id,self.searchBar.text];
    NSLog(@"SearchString===%@",string);
    NSString *encode=[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    ListDetailManager *listDM=[ListDetailManager new];
    [listDM requestDataWithURL:encode];
    __weak typeof (self)temp=self;
    listDM.manager=^(NSMutableArray *array){
        temp.dataArray=array;
        [self getDataMessage];
        [temp.tableView reloadData];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataArray!=0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray!=0) {
        return self.dataArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    C_two_lisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    C_two_lsitModel *model=self.dataArray[indexPath.row];
    cell.title.text=model.title;
    cell.num.text=[NSString stringWithFormat:@"%ld",(long)model.num];
    cell.date.text=model.date;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRESOURCESIMGURL,model.pic]];
    [cell.imgView sd_setImageWithURL:url];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    C_two_lsitModel *model=self.dataArray[indexPath.row];
    LoadResourcesViewController *loadRVC=[[LoadResourcesViewController alloc] init];
    loadRVC.urlString=model.name;
    [self.navigationController pushViewController:loadRVC animated:YES];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray arrayWithCapacity:8];
    }
    return _dataArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar removeFromSuperview];
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
