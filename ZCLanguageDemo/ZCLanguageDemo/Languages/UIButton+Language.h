//
//  UIButton+Language.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/5.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCLanguageConfigueration.h"
@interface UIButton (Language)
-(ZCConfiguerationButtonLanguageBlock)makeTitle;
-(void)switchLanguage;
@end
