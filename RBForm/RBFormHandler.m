//
//  RBFormHandler.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/25.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBFormHandler.h"
#import "RBFormItem.h"
#import "RBFormSectionItem.h"

@implementation RBFormHandler
+ (void)checkFormNullDataWithWithDatas:(NSArray *)datas success:(void(^)(void))success failure:(void(^)(NSString *error))failure {
    for (int sec = 0; sec < datas.count; sec++) {
        RBFormSectionItem *sectionItem = datas[sec];
        for (int row = 0; row < sectionItem.items.count; row++) {
            RBFormItem *rowItem = sectionItem.items[row];
            if (rowItem.itemType == RBFormItemTypeInput_cer || rowItem.itemType == RBFormItemTypeInput || rowItem.itemType == RBFormItemTypeCodeButton || rowItem.itemType == RBFormItemTypePwdButton) {
                if (!rowItem.info || [rowItem.info isEqualToString:@""]) {
                    failure(rowItem.title.length?[NSString stringWithFormat:@"请输入%@",rowItem.title]:rowItem.placeholder);
                    return;
                }
            } else if (rowItem.itemType == RBFormItemTypeSelectImage_cer) {
                if (!rowItem.info || [rowItem.info isEqualToString:@""]) {
                    failure(rowItem.placeholder);
                    return;
                }
            }
        }
    }
    success();
}
@end
