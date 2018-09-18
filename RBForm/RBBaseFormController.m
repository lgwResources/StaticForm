//
//  RBBaseFormController.m
//  RepairBang
//
//  Created by 刘功武 on 2018/7/24.
//  Copyright © 2018年 卓众. All rights reserved.
//

#import "RBBaseFormController.h"
#import "RBFormInputCell.h"
#import "RBFormCodeCell.h"
#import "RBFormPwdCell.h"
#import "RBFormImageCell.h"
#import "RBQualificationCerImageCell.h"
#import "RBQualificationCerInputCell.h"


@interface RBBaseFormController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RBBaseFormController

- (NSMutableArray *)mutableItems {
    if (!_mutableItems) {
        _mutableItems = [[NSMutableArray alloc] init];
    }
    return _mutableItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self addChildViewController:tableViewController];
    [tableViewController.view setFrame:CGRectMake(0, self.navBar.height, screenWidth, screenHeight - self.navBar.height)];
    /**获取tableViewController的tableView实现表单自动上移*/
    _formTableView = tableViewController.tableView;
    _formTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _formTableView.dataSource       = self;
    _formTableView.delegate         = self;
    _formTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _formTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _formTableView.showsVerticalScrollIndicator     = NO;
    _formTableView.showsHorizontalScrollIndicator   = NO;
    _formTableView.backgroundColor = [UIColor clearColor];
    _formTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    _formTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, CGFLOAT_MIN)];
    _formTableView.estimatedRowHeight = 0;
    _formTableView.estimatedSectionHeaderHeight = 0;
    _formTableView.estimatedSectionFooterHeight = 0;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    singleTap.cancelsTouchesInView = NO;
    [_formTableView addGestureRecognizer:singleTap];
    if (@available(iOS 11.0, *)) {
        _formTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_formTableView];
    
    [self setUpCell];
}

#pragma mark -注册nibcell
- (void)setUpCell {
    [RBFormInputCell registerNibToTableView:_formTableView];
    [RBFormCodeCell registerNibToTableView:_formTableView];
    [RBFormPwdCell registerNibToTableView:_formTableView];
    [RBFormImageCell registerNibToTableView:_formTableView];
    [RBQualificationCerInputCell registerNibToTableView:_formTableView];
    [RBQualificationCerImageCell registerNibToTableView:_formTableView];
}

- (void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mutableItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert([self.mutableItems[section] isKindOfClass:[RBFormSectionItem class]]);
    RBFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBFormSectionItem *sectionItem = self.mutableItems[indexPath.section];
    NSParameterAssert([sectionItem.items[indexPath.row] isKindOfClass:[RBFormItem class]]);
    RBFormItem *item = sectionItem.items[indexPath.row];
    RB_WEAKSELF;
    if (item.itemType == RBFormItemTypeCodeButton) {
        /**验证码表单*/
        RBFormCodeCell *codeCell = [tableView dequeueReusableCellWithIdentifier:formCodeCellId];
        codeCell.selectionStyle     = UITableViewCellSelectionStyleNone;
        codeCell.item               = item;
        codeCell.codeCompletion = ^(NSString *text) {
            [weakSelf updateInputWithText:text indexPath:indexPath];
        };
        return codeCell;
    }
    if (item.itemType == RBFormItemTypePwdButton) {
        /**密码表单*/
        RBFormPwdCell *formPwdCell = [tableView dequeueReusableCellWithIdentifier:formPwdCellId];
        formPwdCell.selectionStyle     = UITableViewCellSelectionStyleNone;
        formPwdCell.item               = item;
        formPwdCell.pwdCompletion = ^(NSString *text) {
            [weakSelf updateInputWithText:text indexPath:indexPath];
        };
        return formPwdCell;
    }
    if (item.itemType == RBFormItemTypeInput_cer) {
        RBQualificationCerInputCell *cerInputCell = [tableView dequeueReusableCellWithIdentifier:qualificationCerInputCellId];
        cerInputCell.selectionStyle     = UITableViewCellSelectionStyleNone;
        cerInputCell.item               = item;
        cerInputCell.inputCompletion = ^(NSString *text) {
            [weakSelf updateInputWithText:text indexPath:indexPath];
        };
        return cerInputCell;
    }
    if (item.itemType == RBFormItemTypeSelectImage_cer) {
        /**资质认证选择图片*/
        RBQualificationCerImageCell *cerImageCell = [tableView dequeueReusableCellWithIdentifier:qualificationCerImageCellId];
        cerImageCell.selectionStyle     = UITableViewCellSelectionStyleNone;
        cerImageCell.item               = item;
        cerImageCell.cerImageCompletion = ^(NSString *imageUrl) {
            [weakSelf updateInputWithText:imageUrl indexPath:indexPath];
        };
        return cerImageCell;
    }
    if (item.itemType == RBFormItemType_AD) {
        /**广告表单*/
        RBFormImageCell *formImageCell = [tableView dequeueReusableCellWithIdentifier:formImageCellId];
        formImageCell.selectionStyle     = UITableViewCellSelectionStyleNone;
        formImageCell.item               = item;
        return formImageCell;
    }
    RBFormInputCell *cell   = [tableView dequeueReusableCellWithIdentifier:formInputCellId];
    cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    cell.item               = item;
    cell.inputCompletion = ^(NSString *text) {
        [weakSelf updateInputWithText:text indexPath:indexPath];
    };
    return cell;
}

#pragma mark -TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RBFormSectionItem *sectionItem  = self.mutableItems[indexPath.section];
    NSParameterAssert([sectionItem.items[indexPath.row] isKindOfClass:[RBFormItem class]]);
    RBFormItem *item = sectionItem.items[indexPath.row];
    if (item.itemType == RBFormItemTypeSelectImage_cer) {
        return [RBQualificationCerImageCell cellHeightWithData:item];
    }else {
        return item.defaultHeight>0?item.defaultHeight:48;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RBFormSectionItem *sectionItem  = self.mutableItems[indexPath.section];
    RBFormItem *item                = sectionItem.items[indexPath.row];
    if (item.itemSelectCompletion) {
        item.itemSelectCompletion(item);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    RBFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.headerHeight > 0 ? sectionItem.headerHeight:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    RBFormSectionItem *sectionItem = self.mutableItems[section];
    return sectionItem.footerHeight > 0 ? sectionItem.footerHeight:0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RBFormSectionItem *sectionItem  = self.mutableItems[section];
    UIView *header                  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, sectionItem.headerHeight)];
    header.backgroundColor          = color_f6f6f6;
    return sectionItem.headerView ? sectionItem.headerView:header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    RBFormSectionItem *sectionItem  = self.mutableItems[section];
    UIView *footer                  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, sectionItem.footerHeight)];
    footer.backgroundColor          = color_f6f6f6;
    return sectionItem.footerView ? sectionItem.footerView:footer;
}

#pragma mark -表单响应block处理
- (void)updateInputWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    RBFormSectionItem *sectionItem  = self.mutableItems[indexPath.section];
    RBFormItem *item                = sectionItem.items[indexPath.row];
    item.info                       = text;
}

- (UIView *)footerViewForSuperViewRect:(CGRect)superViewRect btnTitle:(NSString *)btnTitle {
    UIView *footer = [[UIView alloc] initWithFrame:superViewRect];
    footer.backgroundColor  = [UIColor clearColor];
    UIButton *btnAction     = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAction.bounds        = CGRectMake(0, 0, footer.width - 30, 41);
    btnAction.center        = footer.center;
    btnAction.layer.masksToBounds   = YES;
    btnAction.layer.cornerRadius    = 4.f;
    [btnAction setBackgroundImage:[UIImage imageWithColor:mainColor] forState:UIControlStateNormal];
    [btnAction setBackgroundImage:[UIImage imageWithColor:color_3771DC] forState:UIControlStateHighlighted];
    [btnAction setTitle:btnTitle forState:UIControlStateNormal];
    btnAction.titleLabel.font = CUSTOMEFONT(18);
    [btnAction setTitleColor:BACK_COLOR forState:UIControlStateNormal];
    [btnAction addTarget:self action:@selector(btnDidClickAction) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:btnAction];
    
    return footer;
}

- (void) btnDidClickAction {
    
}
@end
