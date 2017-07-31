//
//  Exam_recordManager.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/3.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "Exam_recordManager.h"
#import "Exam_recordModel.h"

@implementation Exam_recordManager

- (void)requestDataWithURL:(NSString *)url{
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSSet *set = [NSSet setWithObject:@"text/html"];
    [sessionManager.responseSerializer setAcceptableContentTypes:set];

    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *dataArray=[NSMutableArray array];
        NSDictionary *dic=responseObject[@"data"][@"t_paper_list"];
        NSMutableArray *keyArray=[NSMutableArray arrayWithArray:dic.allKeys];
        [keyArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 localizedStandardCompare:obj2];
        }];
        for (int i=0; i<keyArray.count; i++) {
            Exam_recordModel *model=[Exam_recordModel new];
            [model setValuesForKeysWithDictionary:dic[keyArray[i]]];
            [dataArray addObject:model];
        }
        self.manager(dataArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

@end
