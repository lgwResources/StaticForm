//
//  RBFormSectionItem.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBFormSectionItem.h"

@implementation RBFormSectionItem

+ (instancetype)rb_sectionItem:(NSArray *)items {
    return [[self alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

@end
