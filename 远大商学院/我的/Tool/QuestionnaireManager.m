//
//  QuestionnaireManager.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/28.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "QuestionnaireManager.h"
#import "QuestionnaireModel.h"

@implementation QuestionnaireManager

-(void)requestDataWithURL:(NSString *)url{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
//    sessionManager.requestSerializer=[AFHTTPRequestSerializer serializer];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];

    sessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //        NSLog(@"downloadProgress==%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *string=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",string);
        NSData *jsonData=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *respon=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"respon=%@",respon);
        NSLog(@"success!");
        // modelArray
        NSMutableArray *array=[NSMutableArray array];
        // keysArray of sorting
        NSDictionary *dic=respon[@"data"][@"data"];
        NSMutableArray *keyArray=[NSMutableArray arrayWithArray:dic.allKeys];
        [keyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
        for (int i=0; i<keyArray.count; i++) {
            QuestionnaireModel *model=[QuestionnaireModel new];
            [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
            [array addObject:model];
        }
        self.manager(array);
        //        NSLog(@"%@",array);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
    
}

-(NSDictionary *)dict{
    if (!_dict) {
        _dict=[NSDictionary dictionary];
    }
    return _dict;
}

@end
