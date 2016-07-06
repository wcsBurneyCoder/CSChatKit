//
//  CSChatToolBar.h
//  CSChatKitDemo
//
//  Created by wangchengshan on 16/7/6.
//  Copyright © 2016年 WCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSChatToolBar;

@protocol CSChatToolBarDelegate <NSObject>

@optional

- (void)toolBar:(CSChatToolBar *)toolBar didChangeHeight:(CGFloat)height;

@end

@interface CSChatToolBar : UIView

/**代理*/
@property (nonatomic, weak) id<CSChatToolBarDelegate> delegate;

@end
