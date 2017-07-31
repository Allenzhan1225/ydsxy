//
//  QuestionnaireDetailViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/13.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "QuestionnaireDetailViewController.h"
#import "QuestionnaireWebViewController.h"

@interface QuestionnaireDetailViewController ()

@property (nonatomic,strong) NSUserDefaults *defaults;

@end

@implementation QuestionnaireDetailViewController

- (void)buildUI{
    self.title=self.model.name;
    self.view.backgroundColor=[UIColor whiteColor];
    _defaults=[NSUserDefaults standardUserDefaults];
    
    for (int i=0; i<6; i++) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(5, 69+kHEIGHT/15.0*i+5*i, kWIDTH-10, kHEIGHT/15.0)];
        switch (i) {
            case 0: // 名称
                label.text=[NSString stringWithFormat:@"名称:%@",self.model.name];
                break;
            case 1: // id
                label.text=[NSString stringWithFormat:@"编号:%d",self.model.id];
                break;
            case 2: // 类型
            {
                if (self.model.type==1) {
                    label.text=@"类型:需求";
                }else if (self.model.type==2){
                    label.text=@"类型:课程";
                }
            }
                break;
            case 3: // 部门
                [self getDepartmentWithLabel:label];
                break;
            case 4: // 添加人
                label.text=[NSString stringWithFormat:@"添加人:%@",self.model.add_u_name];
                break;
            case 5: // 添加日期
                label.text=[NSString stringWithFormat:@"编号:%@",self.model.add_date];
                break;
            default:
                break;
        }
        label.font=[UIFont systemFontOfSize:20];
        [self.view addSubview:label];
    }
    
    UIButton *attendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    attendBtn.frame=CGRectMake(kWIDTH/2.0-60, kHEIGHT/15.0*6+99, 120, kHEIGHT/15.0);
    // 边框、圆角
    attendBtn.layer.borderColor=[[UIColor cyanColor] CGColor];
    attendBtn.layer.borderWidth=1.0f;
    attendBtn.layer.masksToBounds=YES;
    attendBtn.layer.cornerRadius=8;
    // 标题
    [attendBtn setTitle:@"参见问卷" forState:UIControlStateNormal];
    [attendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [attendBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:attendBtn];
}

// 点击跳转界面
- (void)click{
    QuestionnaireWebViewController *webVC=[[QuestionnaireWebViewController alloc] init];
    NSInteger u_id=[_defaults integerForKey:@"u_id"];
    NSString  *url=[NSString stringWithFormat:@"%@u_id=%ld&id=%d",kQUESTIONWEBURL,(unsigned long)u_id,self.model.id];
    webVC.url=url;
    webVC.navTitle=self.model.name;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:webVC animated:YES];
//    self.hidesBottomBarWhenPushed=NO;
}

- (void)getDepartmentWithLabel:(UILabel *)label{
    switch (self.model.department) {
        case 1:
            label.text=@"部门:全体";
            break;
        case 2:
            label.text=@"部门:人资";
            break;
        case 3:
            label.text=@"部门:行政";
            break;
        case 4:
            label.text=@"部门:市场";
            break;
        case 5:
            label.text=@"部门:企划";
            break;
        case 6:
            label.text=@"部门:医生";
            break;
        case 7:
            label.text=@"部门:护理";
            break;
        case 8:
            label.text=@"部门:客服";
            break;
        case 9:
            label.text=@"部门:财务";
            break;
        case 10:
            label.text=@"部门:采购";
            break;
        case 11:
            label.text=@"部门:网络-制作";
            break;
        case 12:
            label.text=@"部门:网络-运营";
            break;
        case 13:
            label.text=@"部门:网络-竞价";
            break;
        case 14:
            label.text=@"部门:网络-咨询";
            break;
        case 15:
            label.text=@"部门:网络-微营销";
            break;
        case 16:
            label.text=@"部门:网络中心";
            break;
        case 17:
            label.text=@"部门:数据中心";
            break;
        case 18:
            label.text=@"部门:事业部";
            break;
        case 19:
            label.text=@"部门:董事办";
            break;
        case 20:
            label.text=@"部门:商学院";
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
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
