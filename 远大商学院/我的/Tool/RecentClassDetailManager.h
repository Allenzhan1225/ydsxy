//
//  RecentClassDetailManager.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/11.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdataUI) (NSMutableArray *array,NSString *timeString);
typedef void (^Enroll) (NSString *string);

@interface RecentClassDetailManager : NSObject

// 默认为NO
- (void)requestDataWithURL:(NSString *)url clickIsOrNo:(BOOL)isOrNo;

@property (nonatomic,copy) UpdataUI manager; // time 时间戳问题，为零时区
@property (nonatomic,copy) Enroll enroll; // 报名

@end
