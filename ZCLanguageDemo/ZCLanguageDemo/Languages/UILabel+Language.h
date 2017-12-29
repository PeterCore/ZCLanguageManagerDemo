//
//  UILabel+Language.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLanguageConfigueration.h"
#import "ZCLanguageMakeModel.h"
@interface UILabel (Language)

@property(nonatomic,strong)ZCLanguageMakeAttributeModel *attributeModel;
@property(nonatomic,strong)NSNumber *orginFontSize;

//-(ZCConfiguerationLanguageBlock)makeLanguage;
//-(ZCConfiguerationMutableAttributeLanguageBlock)makeAttributeLanguage;
-(void)makeAttributeModel:(void(^)(ZCLanguageMakeAttributeModel *attributeModel))block;
-(void)switchLanguage;
-(void)switchLanguageFont:(LanguageFont)font;
@end
