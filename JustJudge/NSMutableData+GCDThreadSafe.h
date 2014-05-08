//
//  NSMutableData+GCDThreadSafe.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GCDThreadSafe.h"

@interface NSMutableData (GCDThreadSafe)

#pragma mark NSData
- (NSUInteger)threadSafe_length;
- (const void *)threadSafe_bytes NS_RETURNS_INNER_POINTER;
- (void)threadSafe_getBytes:(void *)buffer length:(NSUInteger)length;
- (void)threadSafe_getBytes:(void *)buffer range:(NSRange)range;
- (BOOL)threadSafe_isEqualToData:(NSData *)other;
- (NSData *)threadSafe_subdataWithRange:(NSRange)range;
- (BOOL)threadSafe_writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)threadSafe_writeToURL:(NSURL *)url atomically:(BOOL)atomically; // the atomically flag is ignored if the url is not of a type the supports atomic writes

#pragma mark NSMutableData
- (void *)threadSafe_mutableBytes NS_RETURNS_INNER_POINTER;
- (void)threadSafe_setLength:(NSUInteger)length;
- (void)threadSafe_appendBytes:(const void *)bytes length:(NSUInteger)length;
- (void)threadSafe_appendData:(NSData *)other;
- (void)threadSafe_increaseLengthBy:(NSUInteger)extraLength;
- (void)threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;
- (void)threadSafe_resetBytesInRange:(NSRange)range;
- (void)threadSafe_setData:(NSData *)data;
- (void)threadSafe_replaceBytesInRange:(NSRange)range withBytes:(const void *)replacementBytes length:(NSUInteger)replacementLength;

@end
