//
//  ZCLanguageMakeModel.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "ZCLanguageMakeModel.h"
#import "UILabel+Language.h"
#import "NSObject+Language.h"
#import "ZCLanguageManager.h"
#import "ZCAttributedStringLabelTool.h"
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
        [self __configuerationDataSource_UIButton];
    }
}

-(void)__configuerationDataSource_UILabel{
    
}


-(void)__configuerationDataSource_UIButton{
    
}

@end

@implementation ZCLanguageMakeAttributeModel

-(void)__configuerationDataSource_UILabel{
    
   /* UILabel *label = (UILabel*)self.view;
    if (self.text.length&&!label.languageKey)label.languageKey = self.text;
    else if (self.attributeString&&!label.languageKey)label.languageKey = [self.attributeString.string copy];
    else NSAssert(self.text.length && self.attributeString, @"languageKey is not null");
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:label.languageKey languageType:languageType];
    
    if (!language.length&&!language) {
        language = label.languageKey;
    }
    NSAssert(language&&language.length, @"language is not null");
    
    if (self.attributeString) {
        [[ZCAttributedStringLabelTool shareManager] managerAttributeWithNSMutableAttributedString:self.attributeString label:label language:language];
    }
    else{
        if (!label.orginFontSize) {// first init fontSize
            if (!self.fontSize) {
                self.fontSize = 12;
            }
            label.orginFontSize = [[NSNumber alloc] initWithFloat:self.fontSize];
        }
        CGFloat scale = [[ZCLanguageManager shareManager] fetchLanguageFontSize];
        CGFloat fontSize = scale * floorf([label.orginFontSize floatValue]*100/100);
        label.font = self.fontName.length?[UIFont fontWithName:self.fontName size:fontSize]:[UIFont systemFontOfSize:fontSize];
        label.text = language?language:@"";
        label.textColor = self.color?self.color:[UIColor blackColor];
        label.textAlignment = self.textAlignemt;
    }
    label.attributeModel = self;*/
}



@end

@interface ZCLanguageButtonAttributeModel()
@end

@implementation ZCLanguageButtonAttributeModel

-(instancetype)initWithView:(UIView *)view{
    if (self = [super initWithView:view]) {
        
    }
    return self;
}

@end

















