//
//  Header.h
//  远大商学院
//
//  Created by YDWY on 16/7/29.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 高和宽
#define kWIDTH self.view.frame.size.width
#define kHEIGHT self.view.frame.size.height
// cell宽和高
#define kCELLWIDTH self.frame.size.width
#define kCELLHEIGHT self.frame.size.height

// UIScreen width.
#define  LL_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  LL_ScreenHeight  [UIScreen mainScreen].bounds.size.height

//判断iPhoneX
// iPhone X
#define  LL_iPhoneX (LL_ScreenWidth == 375.f && LL_ScreenHeight == 812.f ? YES : NO)
// Status bar height.
#define  LL_StatusBarHeight      (LL_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  LL_NavigationBarHeight  44.f

// Tabbar height.
#define  LL_TabbarHeight         (LL_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  LL_TabbarSafeBottomMargin         (LL_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  LL_StatusBarAndNavigationBarHeight  (LL_iPhoneX ? 88.f : 64.f)

#define LL_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})




// 用户登录与注销
//#define kURLOFUSERLOGIN @"http://peixun.xgyuanda.com/appc/login.html?token=sxyapp&"
//#define kURLOFUSERLOGOUT @"http://peixun.xgyuanda.com/appc/log_out.html?token=sxyapp&"
#define kURLOFUSERLOGIN @"http://peixun.xgyuanda.com/appc/login.html?token=sxyapp&"
#define kURLOFUSERLOGOUT @"http://peixun.xgyuanda.com/appc/log_out.html?token=sxyapp&"

// 首页
// 录入公司消息
//#define kURLOFADD_MESSAGE @"http://peixun.xgyuanda.com/appc/add_msg.html?token=sxyapp&"
#define kURLOFADD_MESSAGE @"http://peixun.xgyuanda.com/appc/add_msg.html?token=sxyapp&"
// 获取公司消息
//#define kURLOFGET_MESSAGE @"http://peixun.xgyuanda.com/appc/get_msg.html?token=sxyapp&"
#define kURLOFGET_MESSAGE @"http://peixun.xgyuanda.com/appc/get_msg.html?token=sxyapp&"
// 最新资讯接口
//#define kLASTESTNEWS @"http://www.xgyuanda.com/lib/api/exe_get_article?token=sxyapp&list_id=37&field=id,list_name,title,filename,senddate"
#define kLASTESTNEWS @"http://www.xgyuanda.com/lib/api/exe_get_article?token=sxyapp&list_id=37&field=id,list_name,title,senddate,filename,litpic"
// 最新资讯详情接口
#define kLASTESTDETAILNEWS @"http://www.xgyuanda.com"

// 资源
//#define kURLOFRESOURCES @"http://peixun.xgyuanda.com/appc/category_index.html?token=sxyapp&"
#define kURLOFRESOURCES @"http://peixun.xgyuanda.com/appc/category_index.html?token=sxyapp&"
// 图片
#define kPICURL @"peixun.xgyuanda.com/Public/uploads/category/big_"
// 二级列表图片
#define kRESOURCESIMGURL @"http://peixun.xgyuanda.com/Public/uploads/resource/images/middle_"
// 一级分类请求
#define kONE_LISTURL @"http://peixun.xgyuanda.com/appc/resource_index.html?&token=sxyapp&"
// 二级请求分类
#define kTWO_LISTURL @"http://peixun.xgyuanda.com/appc/resource_index.html?&token=sxyapp&"
// 文件资源查看
#define kRESOURCES @"http://peixun.xgyuanda.com/Public/uploads/resource/"
// 资源搜索
#define kRESOURCESSEARCH @"http://peixun.xgyuanda.com/appc/resource_index.html?&token=sxyapp&"
// 个人设置
// 课程列表
#define kCOURSELIST @"http://peixun.xgyuanda.com/appc/course_index.html?&token=sxyapp&"
// 课程学习 自选课程报名
#define kCOURSE_ENROLL @"http://peixun.xgyuanda.com/appc/course_enroll.html?&token=sxyapp&"
#define kCOURCESIMGURL @"http://peixun.xgyuanda.com/Public/uploads/course/middle_"
// 在线考试列表
#define kTESTLIST @"http://peixun.xgyuanda.com/appc/test_paper_index.html?&token=sxyapp&"
// 考试图片
#define kTEST_PAPER @"http://peixun.xgyuanda.com/Public/uploads/test_paper/middle_"
// 考试搜索
#define kTESTSEARCH @"http://peixun.xgyuanda.com/appc/test_paper_index.html?&token=sxyapp&u_id="
// 在线考试链接
#define kTESTWEBURL @"http://peixun.xgyuanda.com/appc/examination.html?&token=sxyapp&"
// 问卷列表
#define kQUESTIONLIST @"http://peixun.xgyuanda.com/appc/questionnaire_index.html?&token=sxyapp&"
// 问卷链接
#define kQUESTIONWEBURL @"http://peixun.xgyuanda.com/appc/other_que_assess.html?&token=sxyapp&"
// 考试记录
#define kEXAM_RECORD @"http://peixun.xgyuanda.com/appc/exam_record_index.html?&token=sxyapp&"
// 考试记录查看
#define kVIEW_EXAM_RECORD @"http://peixun.xgyuanda.com/appc/view_exam_record.html?&token=sxyapp&"
// 绩效系统
#define kPERFORMANCESYSTEMURL @"http://o2.xgyuanda.com:2016/Home/authority/login.html"
// 手机招聘
#define kRECRUIT @"http://zp-houtai.xgyuanda.com/mindex.php"
// DISC性格测试
#define kDISC @"http://peixun.xgyuanda.com/DiscApi/all_question?token=sxyapp&u_id="





#endif /* Header_h */
