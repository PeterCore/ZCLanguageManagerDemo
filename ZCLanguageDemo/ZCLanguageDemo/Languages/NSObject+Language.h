//
//  NSObject+Language.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLanguageMakeModel.h"
#import "ZCLanguageConfigueration.h"
@interface NSObject (Language)
@property(nonatomic,strong,setter=setLanguageKey:)NSString *languageKey;
@property(nonatomic,strong,setter=setAttributeString:)NSMutableAttributedString *attributeString;
@property(nonatomic,strong)ZCLanguageMakeModel *makerAttribute;
@property(nonatomic,strong)NSNumber *orginFontSize;

-(void)switchLanguage;
-(void)switchLanguageFont:(LanguageFont)font;
//-(void)swithLanguage;
@end
