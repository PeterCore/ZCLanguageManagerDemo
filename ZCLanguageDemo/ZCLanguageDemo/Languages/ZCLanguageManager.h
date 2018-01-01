//
//  ZCLanguageManager.h
//  QXDriver
//
//  Created by zhangchun on 2017/12/1.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCLanguageConfigueration.h"
@interface ZCLanguageManager : NSObject

+(instancetype)shareManager;

-(void)configuerationWith_plistFile:(NSString*)fileName;

-(void)switchLanguageType:(LanguageType)type completionBlock:(void(^)(BOOL success))completionBlock;

-(void)switchLanguageFont:(LanguageFont)font completionBlock:(void(^)(BOOL success))completionBlock;

-(void)saveLanguageType:(LanguageType)type;

-(void)saveLanguageFontScale:(CGFloat)scale;

-(NSString*)readLanguageWithKey:(NSString*)key languageType:(LanguageType)type;

-(CGFloat)fetchLanguageFontSize;

-(LanguageType)fetchLanguage;

-(void)addControls:(UIView*)control;

-(void)removeControlWithHash:(NSUInteger)hash;

-(id)fetchControlWithHash:(NSUInteger)hash;

@end
