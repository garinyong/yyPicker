//
//  PopBasicView.m
//  yyPicker
//
//  Created by GaoYong on 15/3/9.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "PopBasicView.h"
#import "yyPicker.h"

@implementation PopBasicView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) closeMyPage
{
    if (![self.superview isKindOfClass:[yyPicker class]])
    {
        return;
    }
    
    yyPicker *yySuperView = (yyPicker *)self.superview;
    
    if (yySuperView && [yySuperView respondsToSelector:@selector(closeTopView:)])
    {
        [yySuperView closeTopView:YES];
    }
}

-(void) selectInfo:(id) data
{
    if (![self.superview isKindOfClass:[yyPicker class]])
    {
        return;
    }
    
    yyPicker *yySuperView = (yyPicker *)self.superview;
    
//    yySuperView
}

@end
