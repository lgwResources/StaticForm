//
//  RBFormInputCell.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBCustomCell.h"

@class RBFormItem;
static NSString *formInputCellId = @"RBFormInputCell";
/**输入内容block 当前输入内容*/
typedef void(^RBInputCompletion)(NSString *text);

@interface RBFormInputCell : RBCustomCell

/**配置参数*/
@property (nonatomic, strong) RBFormItem *item;

@property (nonatomic, copy) RBInputCompletion inputCompletion;

@end
