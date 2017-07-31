//
//  CompanyMessageViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/31.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "CompanyMessageViewController.h"

@interface CompanyMessageViewController ()

@end

@implementation CompanyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.view.backgroundColor=[UIColor whiteColor];
    if (self.model.title==nil || [self.model.title isEqual:@""]) {
        self.title=@"暂无标题";
    }else{
        self.title=self.model.title;
    }
    
    UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imgView.frame=CGRectMake(kWIDTH/2.0-45, 70, 90, 90);
    [self.view addSubview:imgView];
    
    // title
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 160, kWIDTH-20, 40)];
    if (self.model.title==nil || [self.model.title isEqual:@""]) {
        titleLabel.text=@"暂无标题";
    }else{
        titleLabel.text=self.model.title;
    }
    titleLabel.font=[UIFont systemFontOfSize:22];
    titleLabel.textColor=[UIColor redColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(20, 206+40*i, kWIDTH-40, 40)];
        if (self.model==nil || !self.model) {
            label.text=@"请联网获取数据";
        }else{
            if (i==0) {
                label.text=[NSString stringWithFormat:@"发布人:%@",self.model.u_name];
            }else{
                label.text=[NSString stringWithFormat:@"发布日期:%@",self.model.add_date];
            }
        }
        label.textAlignment=NSTextAlignmentLeft;
        [self.view addSubview:label];
    }
    
    UILabel *contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 296, kWIDTH-40, kHEIGHT-148)];
    contentLabel.text=[NSString stringWithFormat:@"内容:%@",self.model.content];
    contentLabel.numberOfLines=0;
    contentLabel.lineBreakMode=NSLineBreakByCharWrapping;
    [contentLabel sizeToFit];
    [self.view addSubview:contentLabel];
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
