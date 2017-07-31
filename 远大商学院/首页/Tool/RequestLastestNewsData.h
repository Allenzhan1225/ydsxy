//
//  RequestLastestNewsData.h
//  BusinessSchoolOfYDWY
//
//  Created by YDWY on 16/6/13.
//  Copyright © 2016年 YDWY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdataUI) (NSMutableArray *array);

@interface RequestLastestNewsData : NSObject

@property (nonatomic,copy) UpdataUI managerUI;

- (void)requestDataWithURL:(NSString *)url;

@end
