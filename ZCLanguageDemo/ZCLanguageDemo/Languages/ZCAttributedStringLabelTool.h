//
//  ZCAttributedStringLabelTool.h
//  ZCLanguageDemo
//
//  Created by zhangchun on 2017/12/29.
//  Copyright © 2017年 zhangchun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZCAttributedStringLabelTool : NSObject

+(instancetype)shareManager;
-(void)managerAttributeWithNSMutableAttributedString:(NSMutableAttributedString *)mutableAttributedString
                                               label:(UILabel *)label
                                            language:(NSString*)language;
@end
