//
//  NSMutableString+GCDThreadSafe.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GCDThreadSafe.h"

@interface NSMutableString (GCDThreadSafe)

#pragma mark NSString
- (NSUInteger)threadSafe_length;
- (unichar)threadSafe_characterAtIndex:(NSUInteger)index;
- (NSString *)threadSafe_substringFromIndex:(NSUInteger)from;
- (NSString *)threadSafe_substringToIndex:(NSUInteger)to;
- (NSString *)threadSafe_substringWithRange:(NSRange)range;
- (NSComparisonResult)threadSafe_compare:(NSString *)string;
- (NSComparisonResult)threadSafe_caseInsensitiveCompare:(NSString *)string;
- (NSComparisonResult)threadSafe_localizedCompare:(NSString *)string;
- (NSComparisonResult)threadSafe_localizedCaseInsensitiveCompare:(NSString *)string;
- (BOOL)threadSafe_isEqualToString:(NSString *)aString;
- (BOOL)threadSafe_hasPrefix:(NSString *)aString;
- (BOOL)threadSafe_hasSuffix:(NSString *)aString;
- (NSRange)threadSafe_rangeOfString:(NSString *)aString;
- (NSString *)threadSafe_stringByAppendingString:(NSString *)aString;
- (NSString *)threadSafe_stringByAppendingFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (NSString *)threadSafe_uppercaseString;
- (NSString *)threadSafe_lowercaseString;
- (NSString *)threadSafe_capitalizedString;
- (const char *)threadSafe_UTF8String NS_RETURNS_INNER_POINTER;	// Convenience to return null-terminated UTF8 representation

#pragma mark NSMutableString
- (void)threadSafe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)threadSafe_insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)threadSafe_deleteCharactersInRange:(NSRange)range;
- (void)threadSafe_appendString:(NSString *)aString;
- (void)threadSafe_appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)threadSafe_setString:(NSString *)aString;

@end
