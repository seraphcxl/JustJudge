//
//  NSMutableDictionary+GCDThreadSafe.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSMutableDictionary+GCDThreadSafe.h"

@implementation NSMutableDictionary (GCDThreadSafe)

#pragma mark NSDictionary
- (NSUInteger)threadSafe_count {
    __block NSUInteger result = 0;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self count];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (id)threadSafe_objectForKey:(id)aKey {
    __block id result = nil;
    do {
        if (!aKey) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self objectForKey:aKey];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)threadSafe_allKeys {
    __block NSArray *result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self allKeys];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)threadSafe_allValues {
    __block NSArray *result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self allValues];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#pragma mark NSMutableDictionary
- (void)threadSafe_removeObjectForKey:(id)aKey {
    do {
        if (!aKey) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObjectForKey:aKey];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    do {
        if (!aKey || !anObject) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self setObject:anObject forKey:aKey];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeAllObjects {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeAllObjects];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectsForKeys:(NSArray *)keyArray {
    do {
        if (!keyArray || [keyArray count] == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObjectsForKeys:keyArray];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_setDictionary:(NSDictionary *)otherDictionary {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self setDictionary:otherDictionary];
        }]) {
            break;
        }
    } while (NO);
}

@end
