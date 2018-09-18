//
//  RBFormCodeCell.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/27.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBFormCodeCell.h"
#import "RBFormItem.h"
#import "UIButton+Extension.h"
@interface RBFormCodeCell ()

@property (weak, nonatomic) IBOutlet UILabel            *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelWidth;
@property (weak, nonatomic) IBOutlet UITextField        *contentTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldConstraintL;
@property (weak, nonatomic) IBOutlet UIButton           *codeBtn;

@end

@implementation RBFormCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.codeBtn.layer.masksToBounds    = YES;
    self.codeBtn.layer.cornerRadius     = 4.f;
    self.codeBtn.backgroundColor        = [UIColor whiteColor];
    self.codeBtn.titleLabel.textColor   = mainColor;
    self.codeBtn.layer.borderWidth      = 1.0;
    self.codeBtn.layer.borderColor      = mainColor.CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeDownCountNoti) name:@"removeDownCountNoti" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCodeCountDown) name:codeSuccessNotifi object:nil];
}

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
    if (self.codeCompletion) {
        self.codeCompletion(textField.text);
    }
}

#pragma mark -获取验证码
- (IBAction)codeBtnClick {
    if (self.item.btnClickCompletion) {
        self.item.btnClickCompletion(self.item);
    }
}

- (void)setCodeCountDown {
    [self.codeBtn setCountdown:60];
}

#pragma mark -手动结束倒计时 离开页面之前需要调用
- (void)removeDownCountNoti {
    [self.codeBtn cancelCountdown];
}


@end
