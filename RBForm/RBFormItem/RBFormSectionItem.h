//
//  RBFormSectionItem.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import <Foundation/Foundation.h>

/**RBFormSectionItem 主要对表单section提供动态配置属性*/
@interface RBFormSectionItem : NSObject

/**表单section包含的集合*/
@property (nonatomic, strong) NSArray *items;

/**表单section头部高度*/
@property (nonatomic, assign) CGFloat headerHeight;

/**表单section尾部高度*/
@property (nonatomic, assign) CGFloat footerHeight;

/**表单section头部视图*/
@property (nonatomic, strong) UIView *headerView;

/**表单section尾部视图*/
@property (nonatomic, strong) UIView *footerView;

+ (instancetype)rb_sectionItem:(NSArray *)items;

@end

/**
 RBFormSectionItem 快捷构建表单section
 
 @param items 表单section包含的集合
 */
static inline RBFormSectionItem *sectionItemArr(NSArray *items) {
    return [RBFormSectionItem rb_sectionItem:items];
}
