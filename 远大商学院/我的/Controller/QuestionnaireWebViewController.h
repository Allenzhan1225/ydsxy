//
//  QuestionnaireWebViewController.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/13.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
// 问卷调查详情界面、

#import <UIKit/UIKit.h>
#import "BusinessSchoolNewsModel.h"

@interface QuestionnaireWebViewController : UIViewController

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *navTitle;
@property (nonatomic,strong) BusinessSchoolNewsModel *model;
@property (nonatomic,assign) BOOL isHomePage;
@property (nonatomic,assign) BOOL isPerformSystem;

@end
