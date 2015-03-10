//
//  yyPicker.m
//  yyPicker
//
//  Created by GaoYong on 15/3/5.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "yyPicker.h"
#import "PickerDataItem.h"

#define barHeight 49

@interface yyPicker ()
{
    UIView *topView;     //当前弹出试图
    UIView *markView;    //遮罩层
    UIView *barView;     //底部bar
    CGRect basicFrame;   //初始化的frame
}

@property (nonatomic,retain) NSArray *itemList;
@property (nonatomic) PickerDirection direction;
@property (atomic) int selectIndex;

@end

@implementation yyPicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void) dealloc
{
    [super dealloc];
    
    self.itemList = nil;
}

-(id) initWithFrame:(CGRect)frame direction:(PickerDirection) direction_ itemList:(NSArray *) itemList_
{
    if (self = [super initWithFrame:frame])
    {
        basicFrame = frame;
        self.clipsToBounds = YES;
        self.direction = direction_;
        self.itemList = itemList_;
        self.selectIndex = -1;   //收起状态
        
        [self createBarUI];
    }
    
    return self;
}

-(void) createBarUI
{
    barView = [[UIView alloc] initWithFrame:self.bounds];
    barView.backgroundColor = [UIColor whiteColor];
    [self addSubview:barView];
    [barView release];
    
    CGFloat btnSplitImgWidth = 1;
    CGFloat btnWidth = (self.frame.size.width - btnSplitImgWidth * (_itemList.count - 1)) / _itemList.count;
    
    for (int i = 0; i < _itemList.count; i++)
    {
        PickerDataItem *pdi = [_itemList objectAtIndex:i];
        
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame = CGRectMake(i * btnWidth + btnSplitImgWidth * i, 0, btnWidth, barView.frame.size.height);
        [itemBtn setTitle:pdi.title forState:UIControlStateNormal];
        [itemBtn setImage:pdi.itemImg forState:UIControlStateNormal];
        itemBtn.backgroundColor = [UIColor grayColor];
        itemBtn.tag = i;
        [itemBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [barView addSubview:itemBtn];
        
        //分割线
        if (i < _itemList.count - 1)
        {
            UIImageView *splitImg = [[UIImageView alloc] initWithFrame:CGRectMake(btnWidth * (i + 1) + btnSplitImgWidth * i, 0, btnSplitImgWidth, barView.frame.size.height)];
            splitImg.backgroundColor = [UIColor blackColor];
            [barView addSubview:splitImg];
            [splitImg release];
        }
    }
}

-(void) itemClick:(id) sender
{
    @synchronized(self)
    {
        int nextSelectIndex = (int)((UIButton *)sender).tag;
        
        if(nextSelectIndex >= _itemList.count)
            return;
        
        //弹出新的
        if (self.selectIndex == -1)
        {
            [self showTopView:[self popNewTopView:nextSelectIndex]];
            self.selectIndex = nextSelectIndex;
        }
        else if (self.selectIndex >= 0)
        {
            //收起当前
            if (self.selectIndex == nextSelectIndex)
            {
                [self closeTopView:YES];
            }
            else
            {
                //收起当前
                [self closeTopView:NO];
                //弹出新的
                [self showTopView:[self popNewTopView:nextSelectIndex]];
                self.selectIndex = nextSelectIndex;
            }
        }
    }
}

-(UIView *) popNewTopView:(int) nextSelectIndex
{
    PickerDataItem *selectItem = [_itemList objectAtIndex:nextSelectIndex];
    
    return selectItem.itemUI;
}

-(void) showTopView:(UIView *) newTopView
{
    if (newTopView == nil)
    {
        return;
    }
    
    if (topView == newTopView)
    {
        [self closeTopView:YES];
        return;
    }
    
    if (topView)
    {
        [topView removeFromSuperview];
        topView = nil;
    }
    
    topView = newTopView;
    [self insertSubview:topView belowSubview:barView];
    
    if (markView)
    {
        [markView removeFromSuperview];
        markView = nil;
    }
    
    CGRect barViewInWindow = [barView convertRect:barView.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    if (!markView)
    {
        if (_direction == Top)
        {
            markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.superview.bounds.size.height - barView.bounds.size.height)];
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - markView.bounds.size.height, self.bounds.size.width, self.superview.bounds.size.height);
            
            barView.frame = CGRectMake(barView.frame.origin.x, markView.bounds.size.height, barView.frame.size.width, barView.frame.size.height);
        }
        else
        {
            markView = [[UIView alloc] initWithFrame:CGRectMake(0, barView.bounds.size.height, self.bounds.size.width, self.superview.bounds.size.height - barView.bounds.size.height)];
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.superview.bounds.size.height);
            
//            barView.frame = CGRectMake(barView.frame.origin.x, barView.frame.origin.y, barView.frame.size.width, barView.frame.size.height);
        }
        
        markView.backgroundColor = [UIColor blackColor];
        markView.alpha = 0;
        [self insertSubview:markView belowSubview:topView];
        [markView release];
        
        UITapGestureRecognizer *closeTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTapGesEvent)];
        markView.userInteractionEnabled = YES;
        [markView addGestureRecognizer:closeTapGes];
        [closeTapGes release];
    }
    
    if (_direction == Top)
    {
        topView.frame = CGRectMake(topView.frame.origin.x, barView.frame.origin.y, barView.bounds.size.width, topView.frame.size.height);
    }
    else
    {
        topView.frame = CGRectMake(topView.frame.origin.x, barView.frame.origin.y + barView.frame.size.height - topView.frame.size.height, barView.bounds.size.width, topView.frame.size.height);
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        
        markView.alpha = 0.5;
        
        if (_direction == Top)
        {
            topView.frame = CGRectMake(topView.frame.origin.x, topView.frame.origin.y - topView.frame.size.height, topView.frame.size.width, topView.frame.size.height);
        }
        else
        {
            topView.frame = CGRectMake(topView.frame.origin.x, topView.frame.origin.y + topView.frame.size.height, topView.frame.size.width, topView.frame.size.height);
        }
        
    }completion:^(BOOL finished) {
        
    }];
}

-(void) closeTapGesEvent
{
    [self closeTopView:YES];
}

-(void) closeTopView:(BOOL) animated
{
    if (!topView || !markView)
    {
        return;
    }
    
    if (animated)
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            markView.alpha = 0;
            if (_direction == Top)
            {
                topView.frame = CGRectMake(topView.frame.origin.x, barView.frame.origin.y, barView.bounds.size.width, topView.frame.size.height);
            }
            else
            {
                topView.frame = CGRectMake(topView.frame.origin.x, barView.frame.origin.y - topView.frame.size.height, barView.bounds.size.width, topView.frame.size.height);
            }
            
        }completion:^(BOOL finished)
         {
             self.frame = basicFrame;
             barView.frame = self.bounds;
             
             [markView removeFromSuperview];
             markView = nil;
             
             [topView removeFromSuperview];
             topView = nil;
             
             self.selectIndex = -1;
         }];
    }
    else
    {
        markView.alpha = 0;
        if (_direction == Top)
        {
            topView.frame = CGRectMake(topView.frame.origin.x, barView.frame.origin.y, barView.bounds.size.width, topView.frame.size.height);
        }
        else
        {
            topView.frame = CGRectMake(topView.frame.origin.x, barView.frame.origin.y - topView.frame.size.height, barView.bounds.size.width, topView.frame.size.height);
        }
        
        self.frame = basicFrame;
        barView.frame = self.bounds;
        
        [markView removeFromSuperview];
        markView = nil;
        
        [topView removeFromSuperview];
        topView = nil;

        self.selectIndex = -1;
    }
}

@end
