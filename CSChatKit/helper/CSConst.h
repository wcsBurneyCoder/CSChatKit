//
//  CSConst.h
//  CSChatKitDemo
//
//  Created by wangchengshan on 16/7/6.
//  Copyright © 2016年 WCS. All rights reserved.
//

//图片路经

#define CSSrcName(directory,file) [[NSString stringWithFormat:@"resource.bundle/%@",directory] stringByAppendingPathComponent:file]

#define CSChatSrcName(name) CSSrcName(@"chat",name)
#define CSToolBarSrcName(name) CSSrcName(@"toolBar",name)
#define CSMessageSrcName(name) CSSrcName(@"message",name)
#define CSEmojiSrcName(name) CSSrcName(@"emoji",name)
#define CSExtraViewSrcName(name) CSSrcName(@"extraView",name)

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width