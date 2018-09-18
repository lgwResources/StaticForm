//
//  RBFormImageCell.h
//  RepairBang
//
//  Created by 刘功武 on 2018/9/12.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBCustomCell.h"
@class RBFormItem;
static NSString *formImageCellId = @"RBFormImageCell";
@interface RBFormImageCell : RBCustomCell
/**配置参数*/
@property (nonatomic, strong) RBFormItem *item;

@end
