//
//  CSChatToolBar.m
//  CSChatKitDemo
//
//  Created by wangchengshan on 16/7/6.
//  Copyright © 2016年 WCS. All rights reserved.
//

#import "CSChatToolBar.h"
#import <YYKit.h>
#import <Masonry.h>

@interface CSChatToolBar ()

/**背景*/
@property (nonatomic, weak) UIImageView *bgImageView;
/**输入框*/
@property (nonatomic, weak) YYTextView *textView;
/**语音切换按钮*/
@property (nonatomic, weak) UIButton *voiceChangeBtn;
/**表情切换按钮*/
@property (nonatomic, weak) UIButton *emojiChangeBtn;
/**扩展切换按钮*/
@property (nonatomic, weak) UIButton *extentionChangeBtn;
/**录音按钮*/
@property (nonatomic, weak) UIButton *recordBtn;

@end

@implementation CSChatToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setSubView];
        
        [self setupLayoout];
    }
    return self;
}

- (void)dealloc
{
    [self.textView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)setSubView
{
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:CSToolBarSrcName(@"chat_bg.png")]];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    UIButton *voiceChangeBtn = [[UIButton alloc]init];
    [voiceChangeBtn setImage:[UIImage imageNamed:CSToolBarSrcName(@"ToolViewInputVoice_35x35_.png")] forState:UIControlStateNormal];
    [voiceChangeBtn setImage:[UIImage imageNamed:CSToolBarSrcName(@"ToolViewInputVoiceHL_35x35_.png")] forState:UIControlStateHighlighted];
    [voiceChangeBtn addTarget:self action:@selector(clickVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:voiceChangeBtn];
    self.voiceChangeBtn = voiceChangeBtn;
    
    YYTextView *textView = [[YYTextView alloc]init];
    textView.layer.cornerRadius = 4;
    textView.layer.borderColor = [UIColor colorWithHexString:@"C6C6C6"].CGColor;
    textView.layer.borderWidth = 1;
    textView.font = [UIFont systemFontOfSize:15.0];
    textView.textColor = [UIColor colorWithHexString:@"333333"];
    [textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:textView];
    self.textView = textView;
    
    UIButton *extentionChangeBtn = [[UIButton alloc]init];
    [extentionChangeBtn setImage:[UIImage imageNamed:CSToolBarSrcName(@"TypeSelectorBtn_Black_35x35_.png")] forState:UIControlStateNormal];
    [extentionChangeBtn setImage:[UIImage imageNamed:CSToolBarSrcName(@"TypeSelectorBtnHL_Black_35x35_.png")] forState:UIControlStateHighlighted];
    [self addSubview:extentionChangeBtn];
    self.extentionChangeBtn = extentionChangeBtn;
    
    UIButton *emojiChangeBtn = [[UIButton alloc]init];
    [emojiChangeBtn setImage:[UIImage imageNamed:CSToolBarSrcName(@"ToolViewEmotion_35x35_.png")] forState:UIControlStateNormal];
    [emojiChangeBtn setImage:[UIImage imageNamed:CSToolBarSrcName(@"ToolViewEmotionHL_35x35_.png")] forState:UIControlStateHighlighted];
    [emojiChangeBtn addTarget:self action:@selector(clickEmojiBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:emojiChangeBtn];
    self.emojiChangeBtn = emojiChangeBtn;
}

- (void)setupLayoout
{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.voiceChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(self.voiceChangeBtn.currentImage.size);
    }];
    
    [self.extentionChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(self.extentionChangeBtn.currentImage.size);
    }];
    
    [self.emojiChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.extentionChangeBtn.mas_left);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(self.extentionChangeBtn.currentImage.size);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.voiceChangeBtn.mas_right).offset(7);
        make.right.equalTo(self.emojiChangeBtn.mas_left).offset(-7);
        make.centerY.equalTo(self);
        make.top.mas_equalTo(7);
    }];
}

#pragma mrk - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize contentSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        if (contentSize.height < 88) {
            if ([self.delegate respondsToSelector:@selector(toolBar:didChangeHeight:)]) {
                [self.delegate toolBar:self didChangeHeight:contentSize.height];
            }
        }
    }
}

#pragma mark - action
- (void)clickVoiceBtn:(UIButton *)button
{
    button.selected = !button.selected;
    [button setImage:[UIImage imageNamed:CSToolBarSrcName(button.selected?@"ToolViewKeyboard_35x35_.png":@"ToolViewInputVoice_35x35_.png")] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:CSToolBarSrcName(button.selected?@"ToolViewKeyboardHL_35x35_.png":@"ToolViewInputVoiceHL_35x35_.png")] forState:UIControlStateHighlighted];
    
}

- (void)clickEmojiBtn:(UIButton *)button
{
    button.selected = !button.selected;
    [button setImage:[UIImage imageNamed:CSToolBarSrcName(button.selected?@"ToolViewKeyboard_35x35_.png":@"ToolViewEmotion_35x35_.png")] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:CSToolBarSrcName(button.selected?@"ToolViewKeyboardHL_35x35_.png":@"ToolViewEmotionHL_35x35_.png")] forState:UIControlStateHighlighted];
}
@end
