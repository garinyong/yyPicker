//
//  ViewController.m
//  yyPicker
//
//  Created by GaoYong on 15/3/5.
//  Copyright (c) 2015年 GaoYong. All rights reserved.
//

#import "ViewController.h"
#import "yyPicker.h"
#import "PickerDataItem.h"
#import "PView1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *pikeDataList = [NSMutableArray array];
    
    PopBasicView *popView = [[PopBasicView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    popView.backgroundColor = [UIColor greenColor];
    
    PickerDataItem *item1 = [[PickerDataItem alloc] init:@"书籍" itemImg:nil selectPickClick:^(id data) {
        
    } itemUI:popView];
    
    PView1 *popViewNN = [[PView1 alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 350)];
    popViewNN.backgroundColor = [UIColor redColor];
    
    PickerDataItem *item2 = [[PickerDataItem alloc] init:@"电器" itemImg:nil selectPickClick:^(id data) {
        
    } itemUI:popViewNN];
    
    popView = [[PopBasicView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 170)];
    popView.backgroundColor = [UIColor yellowColor];
    
    PickerDataItem *item3 = [[PickerDataItem alloc] init:@"区域" itemImg:nil selectPickClick:^(id data) {
        
    } itemUI:popView];
    
    popView = [[PopBasicView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90)];
    popView.backgroundColor = [UIColor blueColor];
    
    PickerDataItem *item4 = [[PickerDataItem alloc] init:@"美食" itemImg:nil selectPickClick:^(id data) {
        
    } itemUI:popView];
    
    [pikeDataList addObject:item1];
    [pikeDataList addObject:item2];
    [pikeDataList addObject:item3];
    [pikeDataList addObject:item4];
    
    yyPicker *picker = [[yyPicker alloc] initWithFrame:CGRectMake(0, 50 , self.view.bounds.size.width, 49) direction:Down itemList:pikeDataList];
    
    [self.view addSubview:picker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
