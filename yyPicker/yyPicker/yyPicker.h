//
//  yyPicker.h
//  yyPicker
//
//  Created by GaoYong on 15/3/5.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Top,
    Down,
} PickerDirection;

@interface yyPicker : UIView

-(id) initWithFrame:(CGRect)frame direction:(PickerDirection) direction_ itemList:(NSArray *) itemList_;

@end
