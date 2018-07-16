//
//  ViewController.m
//  ZCLanguageDemo
//
//  Created by zhangchun on 2017/12/21.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Language.h"
#import "ZCLanguageManager.h"
#import "SecondViewController.h"
#import <AFNetworking/AFNetWorking.h>
@interface ViewController ()
@property(nonatomic ,strong)  AFHTTPSessionManager *httpManager;

@end

@implementation ViewController

-(void)test{
    self.httpManager = [AFHTTPSessionManager manager];
    self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];        //[manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    //self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.httpManager.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    self.httpManager.completionQueue = dispatch_get_main_queue();
    NSDictionary *deviceInfo=@{@"phoneNumber":@"",
                               @"system_version":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                               @"platform":@"iOS",
                               @"model":[[UIDevice currentDevice] model],
                               @"screen":[NSString stringWithFormat:@"%ld*%ld",(long)([[UIScreen mainScreen]bounds].size.width*[UIScreen mainScreen].scale),(long)([[UIScreen mainScreen]bounds].size.height*[UIScreen mainScreen].scale)]};
    
    NSDictionary *body=@{@"user_name":@"zhoutm",
                         @"pwd":@"150401"};
    
    
    
    NSDictionary *param=@{@"engine_version":@"2",
                          @"device_info":deviceInfo,
                          @"body":body};
    [self.httpManager.requestSerializer setValue:@"IResource" forHTTPHeaderField:@"User-Agent"];
    NSURLSessionDataTask *dataTask =[self.httpManager POST:@"http://123.126.34.170:7029/IRES-V2/mobapp/logon.spr?method=login" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSLog(@"-----%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    [dataTask resume];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.backgroundColor = [UIColor blueColor];
    label.textColor = [UIColor redColor];
    label.text = @"选择结束时间";
    label.font = [UIFont systemFontOfSize:14];
    /*[label makeAttributeModel:^(ZCLanguageMakeAttributeModel *attributeModel) {
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
    }];*/
    [self.view addSubview:label];
    
    
    UILabel *label_1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    label_1.backgroundColor = [UIColor blueColor];
    NSMutableAttributedString *mutble = [[NSMutableAttributedString alloc]initWithString:@"订单详情"];
    [mutble addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                            NSFontAttributeName :[UIFont boldSystemFontOfSize:12],
                            } range:NSMakeRange(0, 4)];
    [mutble addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
    [mutble addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 4)];
    label_1.attributedText = mutble;
//    [label_1 makeAttributeModel:^(ZCLanguageMakeAttributeModel *attributeModel) {
//                attributeModel.fontSize = 14;
//                attributeModel.text = @"订单详情";
//                attributeModel.color = [UIColor redColor];
//                attributeModel.textAlignemt = NSTextAlignmentCenter;
//        
////        NSMutableAttributedString *mutble = [[NSMutableAttributedString alloc]initWithString:@"订单详情"];
////        [mutble addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
////                                NSFontAttributeName :[UIFont boldSystemFontOfSize:12],
////                                } range:NSMakeRange(0, 4)];
////        [mutble addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
////        [mutble addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 4)];
//        
//       // attributeModel.attributeString = mutble;
//    }];
    [self.view addSubview:label_1];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    button.backgroundColor = [UIColor blackColor];
    button.tag = 1;
    [button setTitle:@"结束时间" forState:(UIControlStateNormal)];
    [button setTitle:@"结束时间" forState:(UIControlStateHighlighted)];
     button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button_1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    button_1.backgroundColor = [UIColor redColor];
    [button_1 setTitle:@"切换文字" forState:(UIControlStateNormal)];
    [button_1 setTitle:@"切换文字" forState:(UIControlStateSelected)];
    button_1.titleLabel.font = [UIFont systemFontOfSize:15];
    button_1.tag = 2;
    [self.view addSubview:button_1];
    [button_1 addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button_2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
    button_2.backgroundColor = [UIColor redColor];
    button_2.tag = 3;
    [self.view addSubview:button_2];
    [button_2 addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


-(void)click:(UIButton*)sender{
    //[[ZCLanguageManager shareManager] switchLanguageType:(LanguageType_EngLish)];
    if (sender.tag == 1) {
        //[[ZCLanguageManager shareManager] switchLanguageFont:(LanguageFont_Little)];
//        [[ZCLanguageManager shareManager] switchLanguageType:(LanguageType_EngLish) completionBlock:^(BOOL success) {
//
//        }];
        [self test];
    }
    else if(sender.tag == 2){
//        [[ZCLanguageManager shareManager] switchLanguageFont:(LanguageFont_Standard) completionBlock:^(BOOL success) {
//
//        }];
        [[ZCLanguageManager shareManager] switchLanguageType:(LanguageType_ChineseComplex) completionBlock:^(BOOL success) {
            
        }];
    }
    else{
        SecondViewController *secondVc = [[SecondViewController alloc] init];
        [self presentViewController:secondVc animated:YES completion:nil];
    }
        
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
