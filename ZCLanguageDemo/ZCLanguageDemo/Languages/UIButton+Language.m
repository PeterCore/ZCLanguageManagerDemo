//
//  UIButton+Language.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/5.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "UIButton+Language.h"
#import "ZCLanguageManager.h"
//#import <objc/runtime.h>
@interface UIButton(Language_Private)
@property(nonatomic,strong)NSMutableDictionary *stateDictionary;
@end

@implementation UIButton (Language_Private)


-(NSMutableDictionary*)stateDictionary{
    NSMutableDictionary *stateDictionary = objc_getAssociatedObject(self, @selector(stateDictionary));
    if (!stateDictionary) {
        stateDictionary = [[NSMutableDictionary alloc] init];
        [self setStateDictionary:stateDictionary];
    }
    return stateDictionary;
}

-(void)setStateDictionary:(NSMutableDictionary *)stateDictionary{
    objc_setAssociatedObject(self, @selector(stateDictionary), stateDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(ZCConfiguerationButtonLanguageBlock)makeTitle{
    
    ZCConfiguerationButtonLanguageBlock makeTitleBlock = ZCConfiguerationButtonLanguageBlock(title, state){
        NSAssert(title && title.length, @"title must not to be nil ");
        
        LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
        if (!languageType) {
            languageType = LanguageType_default;
        }
        NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:title languageType:languageType];
        [self setTitle:language forState:state];
        [self.stateDictionary setObject:title forKey:@(state)];
        [[ZCLanguageManager shareManager] addControls:self];
        return self;
    };
    return makeTitleBlock;
}

-(void)switchLanguage{
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    if (!languageType) {
        languageType = LanguageType_default;
    }
    [self.stateDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSNumber *state_number = (NSNumber*)key;
        NSString *title        = (NSString*)obj;
        NSString *language     = [[ZCLanguageManager shareManager] readLanguageWithKey:title languageType:languageType];
        [self setTitle:language forState:[state_number integerValue]];
    }];
}

-(void)dealloc{
    [self.stateDictionary removeAllObjects];
    [[ZCLanguageManager shareManager] removeControlWithHash:self.hash];
}


@end
