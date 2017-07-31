//
//  C_one_listViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/7.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "C_one_listViewController.h"
#import "C_two_listTableViewController.h"
#import "SearchViewController.h"
//#import "C_two_listViewController.h"

@interface C_one_listViewController ()<ViewPagerDelegate,ViewPagerDataSource>
@property (nonatomic,retain) NSArray *dataArray;

@end

@implementation C_one_listViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title=self.name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    
    self.dataSource=self;
    self.delegate=self;
    self.view.backgroundColor=[UIColor whiteColor];
//    self.dataArray=@[@"微课程",@"视频",@"课程PPT",@"案例集锦",@"经典故事",@"专业知识库",@"其他"];
    // [@7,@8,@9,@10,@11,@12,@13,@14],[@9,@7,@10,@10,@13,@12,@8,@14]
    self.dataArray=@[@"课程PPT",@"微课程",@"案例集锦",@"专业知识库",@"经典故事",@"视频",@"其他"];
}

// 搜索
- (void)search{
    SearchViewController *search=[[SearchViewController alloc] init];
    search.id=self.id;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:search animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark--ViewPagerDelegate,ViewPagerDataSource
-(NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager{
    return self.dataArray.count;
}

-(UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    UILabel *label=[UILabel new];
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:15];
    label.text=[NSString stringWithFormat:@"%@",self.dataArray[index]];
    [label sizeToFit];
    return label;
}

-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    C_two_listTableViewController *c_two_list=[[C_two_listTableViewController alloc] init];
//    C_two_listViewController *c_two_list=[[C_two_listViewController alloc] init];
    
//    NSArray *array=@[@7,@8,@9,@10,@11,@12,@13,@14];
    NSArray *array=@[@9,@7,@10,@10,@13,@12,@8,@14];
    NSString *string=[NSString stringWithFormat:@"%@&c_two_id=%@",self.string,array[index]];
    NSString *str=[string stringByReplacingOccurrencesOfString:@"category" withString:@"resource"];
    NSLog(@"string=%@",str);
    c_two_list.stringUrl=str;
    self.hidesBottomBarWhenPushed=YES;
    return c_two_list;
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
