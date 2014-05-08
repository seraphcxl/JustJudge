//
//  NSMutableString+GCDThreadSafe.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "NSMutableString+GCDThreadSafe.h"

@implementation NSMutableString (GCDThreadSafe)

#pragma mark NSString
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

- (unichar)threadSafe_characterAtIndex:(NSUInteger)index {
    __block unichar result = 0;
    do {
        if (index >= [self threadSafe_length]) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self characterAtIndex:index];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_substringFromIndex:(NSUInteger)from {
    __block NSString *result = nil;
    do {
        if (from >= [self threadSafe_length]) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self substringFromIndex:from];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_substringToIndex:(NSUInteger)to {
    __block NSString *result = nil;
    do {
        if (to >= [self threadSafe_length]) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self substringToIndex:to];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_substringWithRange:(NSRange)range {
    __block NSString *result = nil;
    do {
        if (range.length == 0) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self substringWithRange:range];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)threadSafe_compare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self compare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)threadSafe_caseInsensitiveCompare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self caseInsensitiveCompare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)threadSafe_localizedCompare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self localizedCompare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSComparisonResult)threadSafe_localizedCaseInsensitiveCompare:(NSString *)string {
    __block NSComparisonResult result = NSOrderedSame;
    do {
        if (!string) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self localizedCaseInsensitiveCompare:string];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_isEqualToString:(NSString *)aString {
    __block BOOL result = NO;
    do {
        if (!aString) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self isEqualToString:aString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_hasPrefix:(NSString *)aString {
    __block BOOL result = NO;
    do {
        if (!aString) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self hasPrefix:aString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (BOOL)threadSafe_hasSuffix:(NSString *)aString {
    __block BOOL result = NO;
    do {
        if (!aString) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self hasSuffix:aString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSRange)threadSafe_rangeOfString:(NSString *)aString {
    __block NSRange result = NSMakeRange(0, 0);
    do {
        if (!aString) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self rangeOfString:aString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_stringByAppendingString:(NSString *)aString {
    __block NSString *result = [self copy];
    do {
        if (!aString) {
            break;
        }
        if (![self threadSafe_QueueSync:^{
            result = [self stringByAppendingString:aString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_stringByAppendingFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    __block NSString *result = [self copy];
    do {
        if (!format) {
            break;
        }
        va_list arglist;
        va_start(arglist, format);
        NSString *statement = [[NSString alloc] initWithFormat:format arguments:arglist];
        va_end(arglist);
        if (![self threadSafe_QueueSync:^{
            result = [self stringByAppendingString:statement];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_uppercaseString {
    __block NSString *result = [self copy];
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self uppercaseString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_lowercaseString {
    __block NSString *result = [self copy];
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self lowercaseString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (NSString *)threadSafe_capitalizedString {
    __block NSString *result = [self copy];
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self capitalizedString];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

- (const char *)threadSafe_UTF8String {
    __block const char *result = nil;
    do {
        if (![self threadSafe_QueueSync:^{
            result = [self UTF8String];
        }]) {
            break;
        }
    } while (NO);
    return result;
}

#pragma mark NSMutableString
- (void)threadSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    do {
        if (range.length == 0 || !aString) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self replaceCharactersInRange:range withString:aString];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    do {
        if (!aString || loc > [self threadSafe_length]) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self insertString:aString atIndex:loc];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_deleteCharactersInRange:(NSRange)range {
    do {
        if (range.length == 0) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self deleteCharactersInRange:range];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_appendString:(NSString *)aString {
    do {
        if (!aString) {
            break;
        }
        if (![self threadSafe_QueueBarrierAsync:^{
            [self appendString:aString];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
    do {
        if (!format) {
            break;
        }
        va_list arglist;
        va_start(arglist, format);
        NSString *statement = [[NSString alloc] initWithFormat:format arguments:arglist];
        va_end(arglist);
        if (![self threadSafe_QueueBarrierAsync:^{
            [self appendString:statement];
        }]) {
            break;
        }
    } while (NO);
}

- (void)threadSafe_setString:(NSString *)aString {
    do {
        if (![self threadSafe_QueueBarrierAsync:^{
            [self setString:aString];
        }]) {
            break;
        }
    } while (NO);
}

@end
