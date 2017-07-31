//
//  ClassDetailViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/13.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "QRCodeVC.h"
#import "UIViewExt.h"

@interface ClassDetailViewController ()

@property (nonatomic,assign) BOOL isCollection;

@property (nonatomic,retain) DataBase *database;

@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HistoryDataBase *historyDB=[HistoryDataBase shareDataBase];
    [historyDB insertCourses:self.model];
    [historyDB closeDB];
    
    self.database=[DataBase shareDataBase];
    
    [self buildUI];
}

- (void)buildUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=self.model.name;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(collectionStatus)];
    [self adjustCollextionStatus];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0 , 64 , kWIDTH, kHEIGHT/3.0)];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kCOURCESIMGURL,self.model.pic]]];
    [self.view addSubview:imgView];
    
    /*
    // 报名、签到按钮
    UIButton *checkinBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    checkinBtn.frame=CGRectMake(kWIDTH/12.0*4, kHEIGHT/3.0+69, kWIDTH/4.0, kHEIGHT/15.0);
    [checkinBtn setTitle:@"签到" forState:UIControlStateNormal];
    [checkinBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [checkinBtn addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    // 设置边框
    checkinBtn.layer.borderColor=[[UIColor blueColor] CGColor];
    checkinBtn.layer.borderWidth=1.0f;
    // 设置圆角
    checkinBtn.layer.masksToBounds=YES;
    checkinBtn.layer.cornerRadius=8;
    [self.view addSubview:checkinBtn];
     */
    
    // 讲师
//    UILabel *teacherLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*6+74, 50, kHEIGHT/15.0)];
    UILabel *teacherLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*5+69, 200, kHEIGHT/15.0)];
//    teacherLabel.text=@"讲师:";
    teacherLabel.text=[NSString stringWithFormat:@"讲师:%@",self.model.docent_name];
    [self.view addSubview:teacherLabel];
    
//    UILabel *teacher=[[UILabel alloc] initWithFrame:CGRectMake(65, kHEIGHT/15.0*6+74, 80, kHEIGHT/15.0)];
//    teacher.text=self.model.docent_name;
//    [self.view addSubview:teacher];
    
    // 开始、结束时间
//    UILabel *startTimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*7+79, kWIDTH-20, kHEIGHT/15.0)];
    UILabel *startTimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*6+74, kWIDTH-20, kHEIGHT/15.0)];
    startTimeLabel.text=[NSString stringWithFormat:@"开始时间:%@",self.model.s_date];
    [self.view addSubview:startTimeLabel];
    
//    UILabel *endTimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*8+84, kWIDTH-20, kHEIGHT/15.0)];
    UILabel *endTimeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*7+79, kWIDTH-20, kHEIGHT/15.0)];
    endTimeLabel.text=[NSString stringWithFormat:@"结束时间:%@",self.model.n_date];
    [self.view addSubview:endTimeLabel];
    
    // 课程介绍
//    UILabel *introduceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*9+85, kWIDTH-20, kHEIGHT/15.0)];
//    UILabel *introduceLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/15.0*8+84, kWIDTH-20, kHEIGHT/15.0)];
    UILabel *introduceLabel=[[UILabel alloc] init];
//    introduceLabel.text=@"介绍:";
    NSString *string=[NSString stringWithFormat:@"介绍:%@",_model.introduce];
    CGRect r=[string boundingRectWithSize:CGSizeMake(300, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    introduceLabel.frame=CGRectMake(10, kHEIGHT/15.0*8+84, kWIDTH-20, r.size.height+5);
//    introduceLabel.backgroundColor=[UIColor cyanColor];
    introduceLabel.text=string;
    introduceLabel.numberOfLines=0;
    [self.view addSubview:introduceLabel];
    
}

- (void)adjustCollextionStatus{
    CoursesModel *model=[self.database selectCoursesCoursesID:self.model.id];
    // 查找
    if (model.id!=0) {
        self.navigationItem.rightBarButtonItem.image=[UIImage imageNamed:@"news_collection_Theselected"];
        self.isCollection=YES;
    }else{
        self.navigationItem.rightBarButtonItem.image=[UIImage imageNamed:@"news_collection"];
        self.isCollection=NO;
    }
}

- (void)collectionStatus{
    if (self.isCollection==NO) {
        self.navigationItem.rightBarButtonItem.image=[UIImage imageNamed:@"news_collection_Theselected"];
        // 记录时间
//        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        self.timeStr=[formatter stringFromDate:[NSDate date]];
        self.isCollection=YES;
    }else if (self.isCollection==YES){
        self.navigationItem.rightBarButtonItem.image=[UIImage imageNamed:@"news_collection"];
        self.isCollection=NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    CoursesModel *model=[self.database selectCoursesCoursesID:self.model.id];
    if (self.isCollection==YES && model.id==0) {
        // 收藏
        [self.database insertCourses:self.model];
    }else if (self.isCollection==NO && model.id!=0){
        // 移除
        [self.database deleteCoursesWithCourseID:self.model.id];
    }
    [self.database closeDB];
}

//- (void)check{
//    self.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:[QRCodeVC new] animated:YES];
//}

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
