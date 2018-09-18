//
//  RBFormCodeCell.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/27.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBCustomCell.h"
@class RBFormItem;
static NSString *formCodeCellId = @"RBFormCodeCell";
@interface RBFormCodeCell : RBCustomCell
/**配置参数*/
@property (nonatomic, strong) RBFormItem *item;
/**输入内容block 当前输入内容*/
@property(nonatomic, copy) void (^codeCompletion)(NSString *text);
@end
