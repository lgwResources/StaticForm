//
//  RBFormItem.h
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBFormItem;

typedef NS_ENUM(NSInteger, RBFormItemType) {
    /**可输入表单*/
    RBFormItemTypeInput = 0,
    /**可选择表单*/
    RBFormItemTypeSelect = 1,
    /**验证码按钮表单*/
    RBFormItemTypeCodeButton = 2,
    /**密码按钮表单*/
    RBFormItemTypePwdButton = 3,
    /**选择图片表单*/
    RBFormItemTypeSelectImage = 4,
    /**小红点显示表单*/
    RBFormItemTypePoint = 5,
    /**可输入资质认证表单*/
    RBFormItemTypeInput_cer = 6,
    /**选择资质认证图片表单*/
    RBFormItemTypeSelectImage_cer = 7,
    /**广告表单*/
    RBFormItemType_AD = 8,
};

typedef void(^RBItemSelectCompletion)(RBFormItem *item);
typedef void(^RBItemBtnClickCompletion)(RBFormItem *item);

@interface RBFormItem : NSObject

/**表单缺省高度，默认为48.0f*/
@property (nonatomic, assign) CGFloat defaultHeight;

/**表单左侧距离，默认为.0f*/
@property (nonatomic, assign) CGFloat defaultLeft;
/**表单右侧距离，默认为.0f*/
@property (nonatomic, assign) CGFloat defaultRight;

/**表单类型*/
@property (nonatomic, assign) RBFormItemType itemType;

/**表单标题*/
@property (nonatomic, copy) NSString *title;

/**表单内容*/
@property (nonatomic, copy) NSString *info;

/**表单图片链接地址*/
@property (nonatomic, copy) NSString *imageUrl;

/**是否需要验证*/
@property (nonatomic, assign) BOOL isVerification;

/**表单内容颜色 默认color_999999(#999999)*/
@property (nonatomic, strong) UIColor *InfoColor;

/**表单内容文字位置*/
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**表单占位字符*/
@property (nonatomic, copy) NSString *placeholder;

/**是否显示右侧箭头 YES:显示 NO:不显示*/
@property (nonatomic, assign) BOOL showArrowImageView;
/**是否显示小红点*/
@property (nonatomic, assign) BOOL showPointView;

/**表单键盘类型*/
@property (nonatomic, assign) UIKeyboardType keyboardType;

/**表单是否可编辑 YES:可编辑 NO:不可编辑*/
@property (nonatomic, assign) BOOL editable;

/**表单是否必填(必选) YES:必填(必选) NO:可填(可选)*/
@property (nonatomic, assign) BOOL required;

/**最大输入字数 0表示无限制*/
@property (nonatomic, assign) NSUInteger maxInputLength;

/**表单tip 资质认证中用到该字段*/
@property (nonatomic, copy) NSString *tipTitle;

/**表单点击选择事件block*/
@property (nonatomic, copy) RBItemSelectCompletion itemSelectCompletion;
/**表单按钮点击事件block*/
@property (nonatomic, copy) RBItemBtnClickCompletion btnClickCompletion;

+ (instancetype)formItem_AddModelWithTitle:(NSString *)title info:(NSString *)info itemType:(RBFormItemType)itemType editable:(BOOL)editable required:(BOOL)required keyboardType:(UIKeyboardType)keyboardType;

/**资质认证静态页面模型快速构建*/
+ (instancetype)formItem_AddModelWithTipTitle:(NSString *)tipTitle title:(NSString *)title info:(NSString *)info placeholder:(NSString *)placeholder itemType:(RBFormItemType)itemType keyboardType:(UIKeyboardType)keyboardType;

+ (instancetype)formItem_AddModelWithTitle:(NSString *)title info:(NSString *)info itemType:(RBFormItemType)itemType showArrowImageView:(BOOL)showArrowImageView;

+ (instancetype)formItem_AddModelWithImageUrl:(NSString *)imageUrl info:(NSString *)info itemType:(RBFormItemType)itemType;
@end

/**
 formItem_Add        快捷构建新增表单
 @param title        标题
 @param info         详情
 @param itemType     类别
 @param editable     是否可编辑
 @param required     是否必填
 @param keyboardType 键盘类别
 */
static inline RBFormItem *formItem_Add(NSString *title, NSString *info, RBFormItemType itemType, BOOL editable, BOOL required, UIKeyboardType keyboardType) {
    return [RBFormItem formItem_AddModelWithTitle:title info:info itemType:itemType editable:editable required:required keyboardType:keyboardType];
}

/**
 formItem_Add        快捷构建静态表单
 @param title        标题
 @param info         详情
 @param itemType     类别
 @param showArrowImageView   是否显示右侧箭头
 */
static inline RBFormItem *formItem_AddStaticForm(NSString *title, NSString *info,RBFormItemType itemType, BOOL showArrowImageView) {
    return [RBFormItem formItem_AddModelWithTitle:title info:info itemType:itemType showArrowImageView:showArrowImageView];
}

/**
 formItem_Add        快捷构建资质认证静态表单
 @param title        标题
 @param info         详情
 @param itemType     类别
 */
static inline RBFormItem *formItem_AddQualificationCerForm(NSString *tipTitle, NSString *title, NSString *info, NSString *placeholder, RBFormItemType itemType, UIKeyboardType keyboardType) {
    return [RBFormItem formItem_AddModelWithTipTitle:tipTitle title:title info:info placeholder:placeholder itemType:itemType keyboardType:keyboardType];
}

/**
 formItem_Add        快捷构建图片静态表单
 @param imageUrl     图片地址
 @param info         链接地址
 @param itemType     类别
 */
static inline RBFormItem *formItem_AddImageADForm(NSString *imageUrl, NSString *info,RBFormItemType itemType) {
    return [RBFormItem formItem_AddModelWithImageUrl:imageUrl info:info itemType:itemType];
}
