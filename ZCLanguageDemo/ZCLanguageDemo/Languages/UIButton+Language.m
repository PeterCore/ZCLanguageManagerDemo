//
//  UIButton+Language.m
//  QXDriver
//
//  Created by zhangchun on 2017/12/5.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "UIButton+Language.h"
#import "NSObject+Language.h"
#import "ZCLanguageManager.h"
#import <objc/message.h>

//#import <objc/runtime.h>
static CGFloat defaultSize = 12;

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


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelectorDidAppear = @selector(didMoveToSuperview);
        SEL swizzledSelectorDidAppear = @selector(kb_didMoveToSuperview);
        
        Method originalMethodAppear = class_getInstanceMethod(class, originalSelectorDidAppear);
        Method swizzledMethodAppear = class_getInstanceMethod(class, swizzledSelectorDidAppear);
        
        BOOL willAddMethod =
        class_addMethod(class,
                        originalSelectorDidAppear,
                        method_getImplementation(swizzledMethodAppear),
                        method_getTypeEncoding(swizzledMethodAppear));
        
        if (willAddMethod) {
            class_replaceMethod(class,
                                swizzledSelectorDidAppear,
                                method_getImplementation(originalMethodAppear),
                                method_getTypeEncoding(originalMethodAppear));
        } else {
            method_exchangeImplementations(originalMethodAppear, swizzledMethodAppear);
        }
    
        
    });
}

-(void)insertOrignKeyWithState:(UIControlState) state{
    if (![self.stateDictionary objectForKey:@(state)]) {
        NSString *currentTitle = [self titleForState:(state)];
        if(currentTitle){
            [self.stateDictionary setObject:currentTitle forKey:@(state)];
        }
    }
}

-(void)kb_didMoveToSuperview{
    if (!self.orginFontSize) {
        self.orginFontSize = [[NSNumber alloc] initWithFloat:self.titleLabel.font.pointSize];
    }
    
   /* UIControlStateNormal       = 0,
    UIControlStateHighlighted  = 1 << 0,                  // used when UIControl isHighlighted is set
    UIControlStateDisabled     = 1 << 1,
    UIControlStateSelected*/
    [[ZCLanguageManager shareManager] addControls:self];
    [self insertOrignKeyWithState:UIControlStateNormal];
    [self insertOrignKeyWithState:UIControlStateHighlighted];
    [self insertOrignKeyWithState:UIControlStateDisabled];
    [self insertOrignKeyWithState:UIControlStateSelected];
    [self switchLanguage];

}

/*-(void)makeButtonAttributeModel:(void (^)(ZCLanguageButtonAttributeModel *))block{
    ZCLanguageButtonAttributeModel *attributeModel = [[ZCLanguageButtonAttributeModel alloc] initWithView:self];
    if (block) {
        block(attributeModel);
    }
    [attributeModel configuerationDataSource];
    [[ZCLanguageManager shareManager] addControls:self];
}

-(ZCConfiguerationButtonLanguageBlock)makeTitle{
    
    ZCConfiguerationButtonLanguageBlock makeTitleBlock = ZCConfiguerationButtonLanguageBlock(title, state){
        NSAssert(title && title.length, @"title must not to be nil ");
        
       
        LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
        NSString *language = [[ZCLanguageManager shareManager] readLanguageWithKey:title languageType:languageType];
        [self setTitle:language forState:state];
        [self.stateDictionary setObject:title forKey:@(state)];
        
        if (![[ZCLanguageManager shareManager] fetchControlWithHash:self.hash]) {
            [[ZCLanguageManager shareManager] addControls:self];
        }
        return self;
    };
    return makeTitleBlock;
}

-(ZCConfiguerationFontSizeLanguageBlock)makeFontSize{
    
    ZCConfiguerationFontSizeLanguageBlock makeFontSizeBlock = ZCConfiguerationFontSizeLanguageBlock(fontSize){
        if (![[ZCLanguageManager shareManager] fetchControlWithHash:self.hash]) {
            [[ZCLanguageManager shareManager] addControls:self];
        }
        if (!self.orginFontSize) {// first init fontSize
            if (!fontSize) {
                fontSize = defaultSize;
            }
            self.orginFontSize = [[NSNumber alloc] initWithFloat:fontSize];
        }
        CGFloat scale = [[ZCLanguageManager shareManager] fetchLanguageFontSize];
        self.titleLabel.font = [UIFont systemFontOfSize:scale*fontSize];
        return self;
    };
    return makeFontSizeBlock;
}

-(ZCConfiguerationFontNameLanguageBlock)makeFontName{
    ZCConfiguerationFontNameLanguageBlock makeFontNameBlock = ZCConfiguerationFontNameLanguageBlock(fontName){
        if (![[ZCLanguageManager shareManager] fetchControlWithHash:self.hash]) {
            [[ZCLanguageManager shareManager] addControls:self];
        }
        CGFloat fontSize = 0;
        CGFloat scale = [[ZCLanguageManager shareManager] fetchLanguageFontSize];
        if (!self.orginFontSize) {// first init fontSize
            self.orginFontSize = [[NSNumber alloc] initWithFloat:defaultSize];
            fontSize = scale*defaultSize;
        }
        else{
            fontSize = scale*[self.orginFontSize floatValue]*100/100;
        }
        self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
        return self;
    };
    return makeFontNameBlock;
    
}*/

-(void)switchLanguageFont:(LanguageFont)font{
    CGFloat scale = 0;
    switch (font) {
        case LanguageFont_Little:
            scale = LittleScale;
            break;
        case LanguageFont_Standard:
            scale = StandardScale;
            break;
        case LanguageFont_Big:
            scale = BigScale;
            break;
        default:
            break;
    }
    [[ZCLanguageManager shareManager]saveLanguageFontScale:scale];
    CGFloat fontSize = scale * floorf([self.orginFontSize floatValue]*100/100);
    NSString *fontName = self.titleLabel.font.fontName;
    if(fontSize != self.titleLabel.font.pointSize)
    self.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
}

-(void)switchLanguage{
    LanguageType languageType = [[ZCLanguageManager shareManager] fetchLanguage];
    [self.stateDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSNumber *state_number = (NSNumber*)key;
        NSString *title        = (NSString*)obj;
        NSString *language     = [[ZCLanguageManager shareManager] readLanguageWithKey:title languageType:languageType];
        language = language?language:title;
        [self setTitle:language forState:[state_number integerValue]];
    }];
}

-(void)dealloc{
    [self.stateDictionary removeAllObjects];
    [[ZCLanguageManager shareManager] removeControlWithHash:self.hash];
}


@end
