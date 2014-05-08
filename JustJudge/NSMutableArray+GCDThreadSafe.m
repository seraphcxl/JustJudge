//
//  NSMutableArray+GCDThreadSafe.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSMutableArray+GCDThreadSafe.h"

@implementation NSMutableArray (GCDThreadSafe)

#pragma mark NSArray
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

- (id)threadSafe_objectAtIndex:(NSUInteger)index {
    __block id result = nil;
    do {
        if (index >= [self threadSafe_count]) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self objectAtIndex:index];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSUInteger)threadSafe_indexOfObject:(id)anObject {
    __block NSUInteger result = 0;
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self indexOfObject:anObject];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#if NS_BLOCKS_AVAILABLE
- (NSArray *)threadSafe_sortedArrayUsingComparator:(NSComparator)cmptr {
    __block NSArray *result = nil;
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self sortedArrayUsingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSArray *)threadSafe_sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    __block NSArray *result = nil;
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self sortedArrayWithOptions:opts usingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
    return result;
}
#endif

#pragma mark NSMutableArray
- (void)threadSafe_addObject:(id)anObject {
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self addObject:anObject];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_insertObject:(id)anObject atIndex:(NSUInteger)index {
    do {
        if (!anObject || index > [self threadSafe_count]) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self insertObject:anObject atIndex:index];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeLastObject {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeLastObject];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectAtIndex:(NSUInteger)index {
    do {
        if (index >= [self threadSafe_count]) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObjectAtIndex:index];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    do {
        if (!anObject || index >= [self threadSafe_count]) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self replaceObjectAtIndex:index withObject:anObject];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_addObjectsFromArray:(NSArray *)otherArray {
    do {
        if (!otherArray || [otherArray count] == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self addObjectsFromArray:otherArray];
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

- (void)threadSafe_removeObject:(id)anObject inRange:(NSRange)range {
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObject:anObject inRange:range];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObject:(id)anObject {
    do {
        if (!anObject) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObject:anObject];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectsInArray:(NSArray *)otherArray {
    do {
        if (!otherArray || [otherArray count] == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObjectsInArray:otherArray];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_removeObjectsInRange:(NSRange)range {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self removeObjectsInRange:range];
        }]) {
            break;
        }
    } while (NO);
}

#if NS_BLOCKS_AVAILABLE
- (void)threadSafe_sortUsingComparator:(NSComparator)cmptr {
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self sortUsingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr {
    do {
        if (!cmptr) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self sortedArrayWithOptions:opts usingComparator:cmptr];
        }]) {
            break;
        }
    } while (NO);
}
#endif

@end
