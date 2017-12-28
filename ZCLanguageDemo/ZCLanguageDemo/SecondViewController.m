//
//  SecondViewController.m
//  ZCLanguageDemo
//
//  Created by zhangchun on 2017/12/29.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "SecondViewController.h"
#import "UILabel+Language.h"
#import "ZCLanguageManager.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.backgroundColor = [UIColor blueColor];
    [label makeAttributeModel:^(ZCLanguageMakeAttributeModel *attributeModel) {
        //        attributeModel.fontSize = 14;
        //        attributeModel.text = @"订单详情";
        //        attributeModel.color = [UIColor redColor];
        //        attributeModel.textAlignemt = NSTextAlignmentCenter;
        
        NSMutableAttributedString *mutble = [[NSMutableAttributedString alloc]initWithString:@"选择结束时间"];
        [mutble addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                NSFontAttributeName :[UIFont boldSystemFontOfSize:20],
                                } range:NSMakeRange(0, 6)];
        //        [mutble addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 6)];
        //        [mutble addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, 6)];
        
        attributeModel.attributeString = mutble;
    }];
    [self.view addSubview:label];
    
    
    UILabel *label_1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    label_1.backgroundColor = [UIColor blueColor];
    [label_1 makeAttributeModel:^(ZCLanguageMakeAttributeModel *attributeModel) {
        attributeModel.fontSize = 14;
        attributeModel.text = @"订单详情";
        attributeModel.color = [UIColor redColor];
        attributeModel.textAlignemt = NSTextAlignmentCenter;
        
        //        NSMutableAttributedString *mutble = [[NSMutableAttributedString alloc]initWithString:@"订单详情"];
        //        [mutble addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
        //                                NSFontAttributeName :[UIFont boldSystemFontOfSize:12],
        //                                } range:NSMakeRange(0, 4)];
        //        [mutble addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
        //        [mutble addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 4)];
        
        // attributeModel.attributeString = mutble;
    }];
    [self.view addSubview:label_1];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    button.backgroundColor = [UIColor blackColor];
    button.tag = 1;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button_1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    button_1.backgroundColor = [UIColor redColor];
    button_1.tag = 2;
    [self.view addSubview:button_1];
    [button_1 addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button_2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
    button_2.backgroundColor = [UIColor grayColor];
    button_2.tag = 3;
    [self.view addSubview:button_2];
    [button_2 addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)click:(UIButton*)sender{
    //[[ZCLanguageManager shareManager] switchLanguageType:(LanguageType_EngLish)];
    if (sender.tag == 1) {
        [[ZCLanguageManager shareManager] switchLanguageFont:(LanguageFont_Little)];
    }
    else if(sender.tag == 2){
        [[ZCLanguageManager shareManager] switchLanguageFont:(LanguageFont_Standard)];

    }
    else  [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
