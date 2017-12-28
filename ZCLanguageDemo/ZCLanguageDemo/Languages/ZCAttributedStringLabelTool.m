//
//  ZCAttributedStringLabelTool.m
//  ZCLanguageDemo
//
//  Created by zhangchun on 2017/12/29.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import "ZCAttributedStringLabelTool.h"
#import "ZCLanguageManager.h"
@implementation ZCAttributedStringLabelTool

static ZCAttributedStringLabelTool *__tool = nil;

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __tool = [[[ZCAttributedStringLabelTool class] alloc] init];
    });
    return __tool;
}

-(void)managerAttributeWithNSMutableAttributedString:(NSMutableAttributedString *)mutableAttributedString
                                               label:(UILabel *)label
                                            language:(NSString*)language
{
    NSRange range = NSMakeRange(0, mutableAttributedString.string.length);
    NSMutableAttributedString *mutString = [mutableAttributedString mutableCopy];
    [mutString enumerateAttribute:NSFontAttributeName
                          inRange:range
                          options:(NSAttributedStringEnumerationReverse) usingBlock:^(UIFont *value, NSRange range, BOOL * _Nonnull stop){
                              if (value) {
                                  *stop = YES;
                                  CGFloat fontSize = value.pointSize;
                                  NSString *fontName = value.fontName;
                                  NSDictionary *dictionary = [mutString attributesAtIndex:0 effectiveRange:&range];
                                  NSMutableDictionary *mutable_dictionary = [[NSMutableDictionary alloc]init];
                                  [mutable_dictionary addEntriesFromDictionary:dictionary];
                                  CGFloat scale = [[ZCLanguageManager shareManager] fetchLanguageFontSize];
                                  [mutable_dictionary setValue:[UIFont fontWithName:fontName size:scale * fontSize] forKey:NSFontAttributeName];
                                  [mutString addAttributes:mutable_dictionary range:range];
                                  [mutString replaceCharactersInRange:range withString:language];
                                  
                                  //self.attributeModel.attributeString = mutString;
                                  label.attributedText = mutString;
                              }
                          }];
}

@end
