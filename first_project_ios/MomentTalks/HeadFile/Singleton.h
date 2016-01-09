//
//  Singleton.h
//  zhengzai.tv
//
//  Created by 孙超 on 15/2/25.
//  Copyright (c) 2015年 zhengzai.tv. All rights reserved.
//

#undef	AS_SINGLETON
#define AS_SINGLETON \
    - (instancetype)sharedInstance; \
    + (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
    - (instancetype)sharedInstance \
    { \
        return [[self class] sharedInstance]; \
    } \
    + (instancetype)sharedInstance \
    { \
        static dispatch_once_t once; \
        static id __singleton__; \
        dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
        return __singleton__; \
    }

#undef	DEF_SINGLETON_AUTOLOAD
#define DEF_SINGLETON_AUTOLOAD \
    DEF_SINGLETON \
    + (void)load \
    { \
        [self sharedInstance]; \
    }
