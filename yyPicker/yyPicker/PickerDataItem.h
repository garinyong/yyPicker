//
//  PickerDataItem.h
//  yyPicker
//
//  Created by GaoYong on 15/3/5.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PopBasicView.h"

typedef void(^selectPickBlock)(id data);

@interface PickerDataItem : NSObject

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) UIImage *itemImg;
@property (nonatomic,retain) UIView *itemUI;
@property (nonatomic,copy) selectPickBlock selectPickClick;  //选中回调


-(id) init:(NSString *) title itemImg:(UIImage *) itemImg selectPickClick:(selectPickBlock) selectPickClick itemUI:(PopBasicView *) itemUI;

@end
