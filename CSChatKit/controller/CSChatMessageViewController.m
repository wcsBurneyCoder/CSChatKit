//
//  CSChatMessageViewController.m
//  CSChatKitDemo
//
//  Created by wangchengshan on 16/7/6.
//  Copyright © 2016年 WCS. All rights reserved.
//

#import "CSChatMessageViewController.h"
#import "CSChatToolBar.h"
#import <Masonry.h>

static CGFloat toolBarBottomMargin_ = 0;
static CGFloat toolBarHeight_ = 49;

@interface CSChatMessageViewController ()<CSChatToolBarDelegate>

@end

@implementation CSChatMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建子控件
    [self setupSubView];
    //布局子控件
    [self layoutSubView];
    
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupSubView
{
    if (self.toolBar == nil) {
        CSChatToolBar *toolBar = [[CSChatToolBar alloc]init];
        toolBar.delegate = self;
        self.toolBar = toolBar;
    }
}

- (void)layoutSubView
{
    if (self.toolBar) {
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(toolBarBottomMargin_);
            make.right.equalTo(self.view);
            make.height.mas_equalTo(toolBarHeight_);
        }];
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.toolBar.mas_top);
        }];
    }
    
    [self.view layoutIfNeeded];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 通知
- (void)keyBoardFrameWillChange:(NSNotification *)notice
{
    CGRect keyBoardEndFrame = [[notice.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    CGFloat keyboardY = keyBoardEndFrame.origin.y;
    NSTimeInterval duration = [[notice.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    toolBarBottomMargin_ = -SCREEN_HEIGHT + keyboardY;
    [self.toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(toolBarBottomMargin_);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(toolBarHeight_);
    }];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - CSChatToolBarDelegate
- (void)toolBar:(CSChatToolBar *)toolBar didChangeHeight:(CGFloat)height
{
    if (height + 10 > 50) {
        toolBarHeight_ = height + 15;
    }
    else{
        toolBarHeight_ = 49;
    }
    [self.toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(toolBarHeight_);
    }];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - setter
- (void)setToolBar:(UIView *)toolBar
{
    if (![toolBar isKindOfClass:[CSChatToolBar class]]) {
        [self.toolBar removeFromSuperview];
        _toolBar = nil;
    }
    _toolBar = toolBar;
    [self.view addSubview:toolBar];
    [self layoutSubView];
}

@end
