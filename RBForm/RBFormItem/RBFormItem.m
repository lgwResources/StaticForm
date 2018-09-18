//
//  RBFormItem.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBFormItem.h"

@implementation RBFormItem

+ (instancetype)formItem_AddModelWithTitle:(NSString *)title info:(NSString *)info itemType:(RBFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType {
    return [[self alloc]initWithTitle:title info:info itemType:itemType editable:editable required:required keyboardType:keyboardType showArrowImageView:NO];
}

#pragma mark -资质认证静态页面模型快速构建
+ (instancetype)formItem_AddModelWithTipTitle:(NSString *)tipTitle title:(NSString *)title info:(NSString *)info placeholder:(NSString *)placeholder itemType:(RBFormItemType)itemType keyboardType:(UIKeyboardType)keyboardType {
    return [[self alloc] initWithTipTitle:tipTitle title:title info:info placeholder:placeholder itemType:itemType keyboardType:keyboardType];
}

+ (instancetype)formItem_AddModelWithTitle:(NSString *)title info:(NSString *)info itemType:(RBFormItemType)itemType showArrowImageView:(BOOL)showArrowImageView {
    return [[self alloc]initWithTitle:title info:info itemType:itemType editable:NO required:NO keyboardType:UIKeyboardTypeDefault showArrowImageView:showArrowImageView];
}

+ (instancetype)formItem_AddModelWithImageUrl:(NSString *)imageUrl info:(NSString *)info itemType:(RBFormItemType)itemType {
    return [[self alloc]initWithImageUrl:imageUrl info:info itemType:itemType];
}

- (instancetype)initWithTitle:(NSString *)title info:(NSString *)info itemType:(RBFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType showArrowImageView:(BOOL)showArrowImageView{
    self = [super init];
    if (self) {
        self.title          = title;
        self.info           = info;
        self.itemType       = itemType;
        self.editable       = editable;
        self.required       = required;
        self.keyboardType   = keyboardType;
        self.showArrowImageView = showArrowImageView;
        self.defaultLeft    = 0.f;
        self.defaultRight   = 0.f;
        self.defaultHeight  = 48.f;
        self.maxInputLength = 0;
        self.InfoColor      = color_999999;
    }
    return self;
}

- (instancetype)initWithTipTitle:(NSString *)tipTitle title:(NSString *)title info:(NSString *)info placeholder:(NSString *)placeholder itemType:(RBFormItemType)itemType keyboardType:(UIKeyboardType)keyboardType{
    self = [super init];
    if (self) {
        self.tipTitle       = tipTitle;
        self.title          = title;
        self.info           = info;
        self.itemType       = itemType;
        self.keyboardType   = keyboardType;
        self.placeholder    = placeholder;
        self.InfoColor      = color_999999;
        self.defaultHeight  = 48.f;
    }
    return self;
}

- (instancetype)initWithImageUrl:(NSString *)imageUrl info:(NSString *)info itemType:(RBFormItemType)itemType{
    self = [super init];
    if (self) {
        self.imageUrl       = imageUrl;
        self.info           = info;
        self.itemType       = itemType;
        self.defaultHeight  = 48.f;
    }
    return self;
}

@end
