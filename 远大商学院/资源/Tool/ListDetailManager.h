//
//  ListDetailManager.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/7.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdataUI) (NSMutableArray *array);

@interface ListDetailManager : NSObject

- (void)requestDataWithURL:(NSString *)url;

@property (nonatomic,copy) UpdataUI manager;

@end
