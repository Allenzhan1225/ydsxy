//
//  TestViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/4.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "TestViewController.h"
#import "TestDetailTableViewController.h"
#import "TestSearchViewController.h"

@interface TestViewController ()<ViewPagerDataSource,ViewPagerDelegate>

@property (nonatomic,retain) NSArray *array;

@end

@implementation TestViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"在线考试";
    
    self.dataSource=self;
    self.delegate=self;
    self.array=@[@"人资",@"培训",@"行政",@"市场",@"企划",@"医生",@"护理",@"客服",@"财务",@"采购",@"网络-制作",@"网络-运营",@"网络-竞价",@"网络-咨询",@"网络-微营销"];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)search{
    TestSearchViewController *testSVC=[[TestSearchViewController alloc] init];
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:testSVC animated:YES];
}

#pragma mark--ViewPagerDataSource,ViewPagerDelegate
-(NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager{
    return self.array.count;
}

-(UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    UILabel *label=[UILabel new];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    label.text=[NSString stringWithFormat:@"%@",self.array[index]];
    [label sizeToFit];
    return label;
}

-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    TestDetailTableViewController *testDetail=[[TestDetailTableViewController alloc] init];
    testDetail.index=index;
//    NSLog(@"%lu",(unsigned long)index);
    self.hidesBottomBarWhenPushed=YES;
    return testDetail;
}

-(UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color{
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.6];
            break;
            
        default:
            break;
    }
    return color;
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
