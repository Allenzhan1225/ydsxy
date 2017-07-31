//
//  QuestionnaireManager.h
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/28.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdateUI) (NSMutableArray *array);

@interface QuestionnaireManager : NSObject

-(void)requestDataWithURL:(NSString *)url;

@property (nonatomic,copy) UpdateUI manager;

@property (nonatomic,strong) NSDictionary *dict;

@end
