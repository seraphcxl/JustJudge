//
//  NSMutableSet+GCDThreadSafe.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSMutableSet+GCDThreadSafe.h"

@implementation NSMutableSet (GCDThreadSafe)

#pragma mark NSSet
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

- (id)threadSafe_member:(id)object {
    __block id result = nil;
    do {
        if (!object) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self member:object];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)threadSafe_allObjects {
    __block NSArray *result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self allObjects];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_containsObject:(id)anObject {
    __block BOOL result = NO;
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self containsObject:anObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_intersectsSet:(NSSet *)otherSet {
    __block BOOL result = NO;
    do {
        if (!otherSet) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self intersectsSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_isEqualToSet:(NSSet *)otherSet {
    __block BOOL result = NO;
    do {
        if (!otherSet) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self isEqualToSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_isSubsetOfSet:(NSSet *)otherSet {
    __block BOOL result = NO;
    do {
        if (!otherSet) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self isSubsetOfSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (void)threadSafe_makeObjectsPerformSelector:(SEL)aSelector {
    do {
        if (!aSelector) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self makeObjectsPerformSelector:aSelector];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument {
    do {
        if (!aSelector || !argument) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self makeObjectsPerformSelector:aSelector withObject:argument];
        }]) {
            break;
        }
    } while (NO);
}

- (NSSet *)threadSafe_setByAddingObject:(id)anObject {
    __block NSSet *result = nil;
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self setByAddingObject:anObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSSet *)threadSafe_setByAddingObjectsFromSet:(NSSet *)other {
    __block NSSet *result = nil;
    do {
        if (!other) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self setByAddingObjectsFromSet:other];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSSet *)threadSafe_setByAddingObjectsFromArray:(NSArray *)other {
    __block NSSet *result = nil;
    do {
        if (!other) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self setByAddingObjectsFromArray:other];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#pragma mark NSMutableSet
- (void)threadSafe_addObject:(id)object {
    do {
        if (!object) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self addObject:object];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObject:(id)object {
    do {
        if (!object) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObject:object];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_addObjectsFromArray:(NSArray *)array {
    do {
        if (!array || [array count]) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self addObjectsFromArray:array];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_intersectSet:(NSSet *)otherSet {
    do {
        if (!otherSet) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self intersectSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_minusSet:(NSSet *)otherSet {
    do {
        if (!otherSet) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self minusSet:otherSet];
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

- (void)threadSafe_unionSet:(NSSet *)otherSet {
    do {
        if (!otherSet) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self minusSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_setSet:(NSSet *)otherSet {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self setSet:otherSet];
        }]) {
            break;
        }
    } while (NO);
}

@end
