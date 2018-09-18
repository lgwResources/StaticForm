//
//  RBFormHandler.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/25.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBFormHandler : NSObject

/**
 必选(必填)数据空数据校验
 @param datas 表单数据源
 @param success 必选(必填)数据全部校验成功
 @param failure 必选(必填)数据某一项校验失败
 */
+ (void)checkFormNullDataWithWithDatas:(NSArray *)datas success:(void(^)(void))success failure:(void(^)(NSString *error))failure;

@end
