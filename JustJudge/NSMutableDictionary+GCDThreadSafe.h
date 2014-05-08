//
//  NSMutableDictionary+GCDThreadSafe.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GCDThreadSafe.h"

@interface NSMutableDictionary (GCDThreadSafe)

#pragma mark NSDictionary
- (NSUInteger)threadSafe_count;
- (id)threadSafe_objectForKey:(id)aKey;
- (NSArray *)threadSafe_allKeys;
- (NSArray *)threadSafe_allValues;

#pragma mark NSMutableDictionary
- (void)threadSafe_removeObjectForKey:(id)aKey;
- (void)threadSafe_setObject:(id)anObject forKey:(id <NSCopying>)aKey;
- (void)threadSafe_removeAllObjects;
- (void)threadSafe_removeObjectsForKeys:(NSArray *)keyArray;
- (void)threadSafe_setDictionary:(NSDictionary *)otherDictionary;

@end
