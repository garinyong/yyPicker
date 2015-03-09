//
//  PView1.m
//  yyPicker
//
//  Created by GaoYong on 15/3/9.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "PView1.h"

@implementation PView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.bounds = CGRectMake(0, 0, 100, 80);
        itemBtn.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [itemBtn setTitle:@"close" forState:UIControlStateNormal];
        itemBtn.backgroundColor = [UIColor grayColor];
        [itemBtn addTarget:self action:@selector(itemClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtn];
    }
    
    return self;
}

-(void) itemClick
{
    [self closeMyPage];
}


@end
