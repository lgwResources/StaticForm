//
//  RBFormPwdCell.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/27.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBFormPwdCell.h"
#import "RBFormItem.h"

@interface RBFormPwdCell ()
@property (weak, nonatomic) IBOutlet UILabel            *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWidth;
@property (weak, nonatomic) IBOutlet UITextField        *contentTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldConstraintL;
@property (weak, nonatomic) IBOutlet UIButton           *pwdBtn;
@end

@implementation RBFormPwdCell


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setItem:(RBFormItem *)item {
    _item = item;
    self.titleLabel.text                = item.title.length?item.title:@"";
    self.titleLabelWidth.constant       = [self.titleLabel.text widthWithFont:CUSTOMEFONT(14) constrainedToHeight:self.contentView.height-1];
    
    self.contentTextField.text          = item.info;
    self.contentTextField.placeholder   = item.placeholder;
    self.contentTextField.textAlignment = item.textAlignment;
    self.contentTextField.enabled       = item.editable;
    self.contentTextField.keyboardType  = item.keyboardType;
    self.textFieldConstraintL.constant  = item.defaultLeft>0?item.defaultLeft:44;
    self.contentTextField.textColor     = item.InfoColor==nil?color_999999:item.InfoColor;
}

- (void)textChanged:(UITextField *)textField {
    if (self.item.maxInputLength>0 && textField.text.length > self.item.maxInputLength) {
        textField.text = [textField.text substringToIndex:self.item.maxInputLength];
        return;
    }
    /**防止输入时表单因刷新动画抖动*/
    [UIView performWithoutAnimation:^{
        [self.expandableTableView beginUpdates];
        [self.expandableTableView endUpdates];
    }];
    if (self.pwdCompletion) {
        self.pwdCompletion(textField.text);
    }
}

#pragma mark -密码明文暗文切换点击
- (IBAction)pwdBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.contentTextField.secureTextEntry = !self.contentTextField.secureTextEntry;
}
@end
