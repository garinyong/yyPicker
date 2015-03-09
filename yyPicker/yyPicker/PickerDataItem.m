//
//  PickerDataItem.m
//  yyPicker
//
//  Created by GaoYong on 15/3/5.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "PickerDataItem.h"

@implementation PickerDataItem

-(void) dealloc
{
    self.title = nil;
    self.itemImg = nil;
    self.itemUI = nil;
    self.selectPickClick = nil;
    
    [super dealloc];
}

-(id) init:(NSString *) title itemImg:(UIImage *) itemImg selectPickClick:(selectPickBlock) selectPickClick itemUI:(PopBasicView *) itemUI;
{
    if (self = [super init])
    {
        self.title = title;
        self.itemImg = itemImg;
        self.itemUI = itemUI;
        self.selectPickClick = selectPickClick;
    }
    
    return self;
}

@end
