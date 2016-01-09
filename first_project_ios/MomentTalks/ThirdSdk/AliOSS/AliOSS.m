//
//  AliOSS.m
//  zhengzai.tv
//
//  Created by ZZ-SC on 15/4/4.
//  Copyright (c) 2015年 zhengzai.tv. All rights reserved.
//

#import "AliOSS.h"
#import "Singleton.h"
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>

@interface NSData (md5)

- (NSString *)md5;

@end

@implementation NSData (md5)

- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, (CC_LONG)self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

#define kAccessKey @"tbxHvdQsaJbyOY3D"
#define kSecretKey @"sjdIGoQm65Nvo9TlmsWjjN5dIe083K"

@interface AliOSS ()

@property (nonatomic, strong) OSSBucket *bucket;

@end

@implementation AliOSS

DEF_SINGLETON

- (instancetype)init
{
    self = [super init];
    if (self) {
        OSSClient *ossClient = [OSSClient sharedInstanceManage];
        [ossClient setGenerateToken:^NSString *(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource) {
            NSString *signature = nil;
            NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
            signature = [OSSTool calBase64Sha1WithData:content withKey:kSecretKey];
            signature = [NSString stringWithFormat:@"OSS %@:%@", kAccessKey, signature];
            return signature;
        }];
        [ossClient setGlobalDefaultBucketHostId:@"oss-cn-beijing.aliyuncs.com"];
        [ossClient setGlobalDefaultBucketAcl:PUBLIC_READ_WRITE];
    }
    return self;
}

- (OSSBucket *)bucket
{
    if (_bucket == nil) {
        _bucket = [[OSSBucket alloc] initWithBucket:@"pic-yikelive"];
    }
    return _bucket;
}

+ (OSSBucket *)picBucket
{
    return [AliOSS sharedInstance].bucket;
}

+ (void)uploadImage:(UIImage *)image usingCallBack:(void (^)(BOOL isSuccess, NSString *picUrl, NSError *error))uploadCallback withProgressCallback:(void (^)(float pregress))progressCallback
{
    NSData *data = UIImagePNGRepresentation(image);
    OSSData *pngData = [[OSSData alloc] initWithBucket:[AliOSS picBucket] withKey:[NSString stringWithFormat:@"%f%@.png",[NSDate timeIntervalSinceReferenceDate],[data md5]]];
    [pngData setData:data withType:@"image/png"];
    [pngData uploadWithUploadCallback:^(BOOL isSuccess, NSError *error) {
        uploadCallback(isSuccess, [pngData getResourceURL], error);
    } withProgressCallback:^(float progress) {
        progressCallback(progress);
    }];
}

@end
