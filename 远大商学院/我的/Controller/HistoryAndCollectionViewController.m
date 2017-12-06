//
//  HistoryAndCollectionViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "HistoryAndCollectionViewController.h"
#import "CoursesModel.h"
#import "ClassDetailViewController.h"

@interface HistoryAndCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UISegmentedControl *segment;
@property (nonatomic,strong) UITableView *history;
@property (nonatomic,strong) UITableView *collection;

@property (nonatomic,retain) UIView *historyView;
@property (nonatomic,retain) UIView *collectionView;

@property (nonatomic,retain) DataBase *database;
@property (nonatomic,retain) HistoryDataBase *historyDB;
// 收藏、历史记录
@property (nonatomic,retain) NSMutableArray *collectionArray;
@property (nonatomic,retain) NSMutableArray *historyArray;

@end

static NSString *historyCell=@"historyCell";
static NSString *collectionCell=@"collectionCell";

@implementation HistoryAndCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"历史及收藏";
    
    [self getCollestionList];
    [self getHistoryList];
    
    [self buildUI];
}
 
// get collectionList
- (void)getCollestionList{
    self.database=[DataBase shareDataBase];
    NSArray *array=[self.database selectAllCourses];
    self.collectionArray=[array mutableCopy];
}

- (void)getHistoryList{
    self.historyDB=[HistoryDataBase shareDataBase];
    NSArray *array=[self.historyDB selectAllCourses];
    self.historyArray=[array mutableCopy];
}

- (void)buildUI{
    _segment=[[UISegmentedControl alloc] initWithItems:@[@"历史记录",@"收藏"]];
    _segment.frame=CGRectMake(0, LL_NavigationBarHeight+LL_StatusBarHeight, kWIDTH, 40);
    [_segment addTarget:self action:@selector(selIndex:) forControlEvents:UIControlEventValueChanged];
    _segment.tintColor=[UIColor clearColor];
    // 选中字体颜色
    NSDictionary *selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blueColor]};
    [_segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    // 未选中字体颜色
    NSDictionary *unselectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [_segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    _segment.selectedSegmentIndex=0;
    [self.view addSubview:_segment];
    
    self.historyView=[[UIView alloc] initWithFrame:CGRectMake(kWIDTH/4.0-40, 32, 80, 1)];
    self.historyView.backgroundColor=[UIColor blackColor];
    [self.segment addSubview:self.historyView];
    
    _history=[[UITableView alloc] initWithFrame:CGRectMake(0, LL_NavigationBarHeight+LL_StatusBarHeight + 40, kWIDTH, kHEIGHT-LL_NavigationBarHeight-LL_StatusBarHeight-LL_TabbarHeight-40) style:UITableViewStylePlain];
    _history.delegate=self;
    _history.dataSource=self;
    [_history registerClass:[UITableViewCell class] forCellReuseIdentifier:historyCell];
    _history.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:_history];
    
    _collection=[[UITableView alloc] initWithFrame:CGRectMake(0, LL_NavigationBarHeight+LL_StatusBarHeight + 40, kWIDTH, kHEIGHT-LL_NavigationBarHeight-LL_StatusBarHeight-LL_TabbarHeight-40) style:UITableViewStylePlain];
    _collection.delegate=self;
    _collection.dataSource=self;
    [_collection registerClass:[UITableViewCell class] forCellReuseIdentifier:collectionCell];
    self.collection.hidden=YES;
    _collection.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.collection];
    
    self.collectionView=[[UIView alloc] initWithFrame:CGRectMake(kWIDTH/4.0*3-20, 32, 43, 1)];
    self.collectionView.backgroundColor=[UIColor blackColor];
    self.collectionView.hidden=YES;
    [self.segment addSubview:self.collectionView];
}

- (void)selIndex:(UISegmentedControl *)seg{
    NSInteger index=seg.selectedSegmentIndex;
    switch (index) {
        case 0:{ // 历史
            if (_collection!=nil) {
                self.collection.hidden=YES;
                self.collectionView.hidden=YES;
            }
            self.history.hidden=NO;
            self.historyView.hidden=NO;
        }
            break;
        case 1:{ // 收藏
            if (_history!=nil) {
                self.history.hidden=YES;
                self.historyView.hidden=YES;
            }
            self.collection.hidden=NO;
            self.collectionView.hidden=NO;
        }
            break;
        default:
            break;
    }
}

#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==_history) {
        return 1;
    }else if (tableView==_collection){
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_history) {
        if (self.historyArray.count!=0) {
            return self.historyArray.count;
        }
    }else if (tableView==_collection){
        if (self.collectionArray.count!=0) {
            return self.collectionArray.count;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        if (tableView==_history) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historyCell];
            CoursesModel *model=self.historyArray[indexPath.row];
            cell.textLabel.text=model.name;
        }else if (tableView==_collection){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionCell];
            CoursesModel *model=self.collectionArray[indexPath.row];
            cell.textLabel.text=model.name;
        }
    }
    return cell;
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 移除数据之后需要刷新一下
        if (tableView==_history) {
            NSLog(@"history");
            CoursesModel *model=self.historyArray[indexPath.row];
            [self.historyDB deleteCoursesWithCourseID:model.id];
            [self.historyArray removeObjectAtIndex:indexPath.row];
            [self.history reloadData];
        }else{
            NSLog(@"collection");
            CoursesModel *model=self.collectionArray[indexPath.row];
            [self.database deleteCoursesWithCourseID:model.id];
            [self.collectionArray removeObjectAtIndex:indexPath.row];
            [self.collection reloadData];
        }
    }];
    return @[deleteRowAction];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassDetailViewController *classDVC=[[ClassDetailViewController alloc] init];
    CoursesModel *model=(tableView==self.history)?self.historyArray[indexPath.row]:self.collectionArray[indexPath.row];
    classDVC.model=model;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:classDVC animated:YES];
}

// lazy load
-(NSMutableArray *)collectionArray{
    if (!_collectionArray) {
        _collectionArray=[NSMutableArray array];
    }
    return _collectionArray;
}

-(NSMutableArray *)historyArray{
    if (!_historyArray) {
        _historyArray=[NSMutableArray array];
    }
    return _historyArray;
}

/*
-(NSMutableArray *)historySelectArray{
    if (!_historySelectArray) {
        _historySelectArray=[NSMutableArray array];
    }
    return _historySelectArray;
}

-(NSMutableArray *)collectionSelectArray{
    if (!_collectionSelectArray) {
        _collectionSelectArray=[NSMutableArray array];
    }
    return _collectionSelectArray;
}
 */

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.database closeDB];
    [self.historyDB closeDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
