//
//  ZCLanguageMakeModel.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 千夏. All rights reserved.
//

#import "ZCLanguageMakeModel.h"
#import "UILabel+Language.h"


@interface ZCLanguageMakeModel()
@property(nonatomic,strong)UIView *view;
@end

@implementation ZCLanguageMakeModel

-(instancetype)initWithView:(UIView *)view{
    if (self = [super init]) {
        self.view = view;
    }
    return self;
}

-(void)configuerationDataSource{
    if ([self.view isKindOfClass:[UILabel class]]) {
        [self __configuerationDataSource_UILabel];
    }
    else if ([self isKindOfClass:[UIButton class]]){
        
    }
}

-(void)__configuerationDataSource_UILabel{

    
}

@end

@implementation ZCLanguageMakeAttributeModel

-(void)__configuerationDataSource_UILabel{
    
    UILabel *label = (UILabel*)self.view;
    label.font = self.font?self.font:[UIFont systemFontOfSize:12];
    label.text = self.text?self.text:@"";
    label.textColor = self.color?self.color:[UIColor blackColor];
    label.textAlignment = self.textAlignemt;
    if (self.attributeString) {
        label.attributedText = self.attributeString;
    }
    label.attributeModel = self;
//    NSLog(@"attribute is %@",label.attributeModel.text);
//    int i = 0;
}
@end



















