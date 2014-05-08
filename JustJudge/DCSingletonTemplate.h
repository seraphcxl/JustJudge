//
//  DCSingletonTemplate.h
//  CodeGear_ObjC
//
//  Created by Derek Chen on 13-6-7.
//  Copyright (c) 2013年 CaptainSolid Studio. All rights reserved.
//

#ifndef CodeGear_ObjC_DCSingletonTemplate_h
#define CodeGear_ObjC_DCSingletonTemplate_h

/**** **** **** **** **** **** **** ****/
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className; \
+ (void)staticRelease; \

#endif

/**** **** **** **** **** **** **** ****/
#if __has_feature(objc_arc)

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
static className *shared##className = nil; \
\
+ (className *)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        shared##className = [[self alloc] init]; \
    }); \
    return shared##className; \
} \
\
+ (void)staticRelease {}

#else

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
static className *shared##className = nil; \
\
+ (className *)shared##className { \
    @synchronized(self) { \
        if (shared##className == nil) { \
            [[self alloc] init]; \
        } \
    } \
    return shared##className; \
} \
\
+ (void)staticRelease { \
    @synchronized(self) { \
        if (shared##className) { \
            [shared##className dealloc]; \
            shared##className = nil; \
        } \
    } \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
    @synchronized(self) { \
        if (shared##className == nil) { \
            shared##className = [super allocWithZone:zone]; \
            return shared##className; \
        } \
    } \
    return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone { return self; } \
\
- (id)retain { return self; } \
\
- (NSUInteger)retainCount { return UINT_MAX; } \
\
- (oneway void)release {} \
\
- (id)autorelease { return self; }

#endif
