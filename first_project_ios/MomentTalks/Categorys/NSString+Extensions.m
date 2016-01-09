//
//  NSString+Extensions.m
//  17Snooker
//
//  Created by LookMedia-China on 14-4-14.
//  Copyright (c) 2014年 LookMedia-China. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Extensions)


- (NSString *)lowercaseFirstCharacter {
    NSRange range = NSMakeRange(0, 1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)uppercaseFirstCharacter {
    NSRange range = NSMakeRange(0, 1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimTheExtraSpaces {
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    return [filteredArray componentsJoinedByString:@" "];
}

- (BOOL)isValidMobileNumber {
    NSString *Regex = @"(13[0-9]|14[57]|15[012356789]|18[02356789])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:self];
}


- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSURL *)toUrl {
    return [NSURL URLWithString:self];
}

- (UIColor *)toColor {
    NSArray *colors = [self componentsSeparatedByString:@","];
    if (colors.count == 0) return nil;
    int r = [colors[0] intValue];
    int g = [colors[1] intValue];
    int b = [colors[2] intValue];
    double a = 1.0; // 透明度
    if (colors.count > 3) {
        a = [colors[3] doubleValue];
    }
    return RGBCOLORA(r, g, b, a);
}

- (NSString *)trimWhitespace {
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef) str);
    return str;
}

- (BOOL)isEmpty {
    return [[self trimWhitespace] isEqualToString:@""];
}

- (NSString *)md5 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];

    CC_MD5(data.bytes, (int) data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

- (CGFloat)heightForSizeWithFont:(UIFont *)fontSize andWidth:(float)width {

    if (iOS8) {
        NSDictionary *attribute = @{NSFontAttributeName : fontSize};
        CGSize textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return textSize.height;

    }
    CGSize sizeToFit = [self sizeWithFont:fontSize constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit.height;
}

- (CGFloat)widthForSizeFont:(UIFont *)fontSize andHeight:(float)height {
    if (iOS8) {
        NSDictionary *attribute = @{NSFontAttributeName : fontSize};
        CGSize textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        return textSize.width;
    }
    CGSize sizeToFit = [self sizeWithFont:fontSize constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}

- (NSDictionary *)jsonValue {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    return dic;
}

@end