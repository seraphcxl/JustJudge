//
//  NSMutableData+GCDThreadSafe.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSMutableData+GCDThreadSafe.h"

@implementation NSMutableData (GCDThreadSafe)

#pragma mark NSData
- (NSUInteger)threadSafe_length {
    __block NSUInteger result = 0;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self length];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (const void *)threadSafe_bytes {
    __block const void *result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self bytes];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (void)threadSafe_getBytes:(void *)buffer length:(NSUInteger)length {
    do {
        if (!buffer || length == 0) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self getBytes:buffer length:length];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_getBytes:(void *)buffer range:(NSRange)range {
    do {
        if (!buffer || range.length == 0) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            [self getBytes:buffer range:range];
        }]) {
            break;
        }
    } while (NO);
}

- (BOOL)threadSafe_isEqualToData:(NSData *)other {
    __block BOOL result = NO;
    do {
        if (!other) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self isEqualToData:other];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSData *)threadSafe_subdataWithRange:(NSRange)range {
    __block NSData *result = nil;
    do {
        if (range.length == 0) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self subdataWithRange:range];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile {
    __block BOOL result = NO;
    do {
        if (!path) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self writeToFile:path atomically:useAuxiliaryFile];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_writeToURL:(NSURL *)url atomically:(BOOL)atomically {
    __block BOOL result = NO;
    do {
        if (!url) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self writeToURL:url atomically:atomically];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#pragma mark NSMutableData
- (void *)threadSafe_mutableBytes {
    __block void *result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self mutableBytes];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (void)threadSafe_setLength:(NSUInteger)length {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self setLength:length];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_appendBytes:(const void *)bytes length:(NSUInteger)length {
    do {
        if (!bytes || length == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self appendBytes:bytes length:length];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_appendData:(NSData *)other {
    do {
        if (!other) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self appendData:other];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_increaseLengthBy:(NSUInteger)extraLength {
    do {
        if (extraLength == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self increaseLengthBy:extraLength];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes {
    do {
        if (range.length == 0 || !bytes) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self replaceBytesInRange:range withBytes:bytes];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_resetBytesInRange:(NSRange)range {
    do {
        if (range.length == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self resetBytesInRange:range];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_setData:(NSData *)data {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self setData:data];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(NSUInteger)replacementLength {
    do {
        if (range.length == 0 || !replacementBytes || replacementLength == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self replaceBytesInRange:range withBytes:replacementBytes length:replacementLength];
        }]) {
            break;
        }
    } while (NO);
}

@end
