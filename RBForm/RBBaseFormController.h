//
//  RBBaseFormController.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBBaseViewController.h"
#import "RBFormItem.h"
#import "RBFormSectionItem.h"
#import "RBFormHandler.h"

typedef void(^RBFormSubmitCompletion)(void);

/**表单基类，所有表单必须继承于BaseController，实现了表单动态配置*/
@interface RBBaseFormController : RBBaseViewController

@property (nonatomic, assign) CGFloat top;

/**表单tableView*/
@property (nonatomic, strong) UITableView *formTableView;

/**表单数据源，数据源格式应为 @[RBFormSection..]，否则断言会直接崩溃*/
@property (nonatomic, strong) NSMutableArray *mutableItems;

/**提交操作事件block，包含提交操作表单页面提交按钮点击事件实现回调*/
@property (nonatomic, copy) RBFormSubmitCompletion submitCompletion;

- (UIView *)footerViewForSuperViewRect:(CGRect)superViewRect btnTitle:(NSString *)btnTitle;

@end
