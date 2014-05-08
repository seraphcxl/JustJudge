//
//  NSObject+GCDThreadSafe.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/8/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSObject+GCDThreadSafe.h"
#import <objc/runtime.h>

static char NSObjectGCDThreadSafeQueueKey;

@implementation NSObject (GCDThreadSafe)

- (id)threadSafe_init {
    do {
        @synchronized(self) {
            if ([self getGCDThreadSafeQueue]) {
                break;
            }
            NSString *uuid = [NSString stringWithFormat:@"%@_GCDThreadSafeQueue_%p", [[self class] description], self];
            dispatch_queue_t concurrentQueue = dispatch_queue_create([uuid UTF8String], DISPATCH_QUEUE_CONCURRENT);
            [self setGCDThreadSafeQueue:concurrentQueue];
        }
    } while (NO);
    return self;
}

- (void)setGCDThreadSafeQueue:(dispatch_queue_t)concurrentQueue {
    objc_setAssociatedObject(self, &NSObjectGCDThreadSafeQueueKey, concurrentQueue, OBJC_ASSOCIATION_RETAIN);
}

- (dispatch_queue_t)getGCDThreadSafeQueue {
    return (dispatch_queue_t)objc_getAssociatedObject(self, &NSObjectGCDThreadSafeQueueKey);
}

- (BOOL)threadSafe_QueueSync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        dispatch_sync(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)threadSafe_QueueBarrierAsync:(dispatch_block_t)block {
    BOOL result = NO;
    do {
        if (!block) {
            break;
        }
        dispatch_queue_t concurrentQueue = [self getGCDThreadSafeQueue];
        if (!concurrentQueue) {
            break;
        }
        dispatch_barrier_async(concurrentQueue, block);
        result = YES;
    } while (NO);
    return result;
}

@end
