//
//  ViewController.m
//  ZCLanguageDemo
//
//  Created by zhangchun on 2017/12/21.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Language.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.backgroundColor = [UIColor blueColor];
    [label makeAttributeModel:^(ZCLanguageMakeAttributeModel *attributeModel) {
        attributeModel.font = [UIFont systemFontOfSize:14];
        attributeModel.text = @"订单详情";
        attributeModel.color = [UIColor redColor];
        attributeModel.textAlignemt = NSTextAlignmentCenter;
    }];
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
