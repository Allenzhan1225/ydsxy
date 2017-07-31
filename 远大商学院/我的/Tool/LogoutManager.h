//
//  LogoutManager.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/10.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdateUI) (NSString *message);
typedef void (^RequetData) (NSMutableArray *array);

@interface LogoutManager : NSObject

-(void)requestDataWithURL:(NSString *)url;

// 0 退出登录 1 勾餐请求
-(void)requestDataWithURL:(NSString *)url withID:(int)ID;

@property (nonatomic,copy) UpdateUI manager;
@property (nonatomic,copy) RequetData managerRD;

@end
