//
//  ChatInputView.m
//  BuddleChatDemo
//
//  Created by 毛志 on 14-1-7.
//  Copyright (c) 2014年 maozhi. All rights reserved.
//

#import "ChatInputView.h"

@implementation ChatInputView
- (void)dealloc
{
    self.inputView = nil;
    self.sendBtn = nil;
//    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        _inputView = [[UITextView alloc] initWithFrame:CGRectMake(4, 4, 240, 36)];
        _inputView.layer.cornerRadius = 3.0;
        _inputView.layer.borderWidth = 2.0;
        _inputView.layer.borderColor = [UIColor blackColor].CGColor;
        // 指定为17号字体
        _inputView.font = [UIFont systemFontOfSize:17];
        // 高度变化
        _inputView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        _sendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _sendBtn.frame = CGRectMake(250, 4, 60, 36);
        _sendBtn.tintColor = [UIColor blackColor];
        _sendBtn.layer.cornerRadius = 3.0;
        _sendBtn.layer.borderWidth = 2.0;
        _sendBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [_sendBtn setTitle:@"send" forState:UIControlStateNormal];
        
        [self addSubview:_inputView];
        [self addSubview:_sendBtn];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
