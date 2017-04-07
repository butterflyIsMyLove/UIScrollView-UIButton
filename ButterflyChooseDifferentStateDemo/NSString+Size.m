//
//  NSString+Size.m
//  ButterflyChooseDifferentStateDemo
//
//  Created by XiangTaiMini on 2017/3/23.
//  Copyright © 2017年 Butterfly. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

-(CGSize)stringSizeWithFont:(UIFont *)font {
    return [self stringSizeWithFont:font width:MAXFLOAT];
}

-(CGSize)stringSizeWithFont:(UIFont *)font width:(CGFloat)width {
    NSDictionary *attr = @{NSFontAttributeName:font};
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGSize result = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    return result;
}

@end
