//
//  RBFormImageCell.m
//  RepairBang
//
//  Created by 刘功武 on 2018/9/12.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBFormImageCell.h"
#import "RBFormItem.h"
#import "XHLaunchAdImageView+XHLaunchAdCache.h"

@interface RBFormImageCell ()
@property (weak, nonatomic) IBOutlet XHLaunchAdImageView *adImageView;
@end

@implementation RBFormImageCell

- (void)setItem:(RBFormItem *)item {
    _item = item;
    
    [self.adImageView xh_setImageWithURL:[NSURL URLWithString:item.imageUrl]];
}

@end
