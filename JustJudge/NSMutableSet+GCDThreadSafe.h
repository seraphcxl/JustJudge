//
//  NSMutableSet+GCDThreadSafe.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GCDThreadSafe.h"

@interface NSMutableSet (GCDThreadSafe)

#pragma mark NSSet
- (NSUInteger)threadSafe_count;
- (id)threadSafe_member:(id)object;
- (NSArray *)threadSafe_allObjects;
- (BOOL)threadSafe_containsObject:(id)anObject;
- (BOOL)threadSafe_intersectsSet:(NSSet *)otherSet;
- (BOOL)threadSafe_isEqualToSet:(NSSet *)otherSet;
- (BOOL)threadSafe_isSubsetOfSet:(NSSet *)otherSet;
- (void)threadSafe_makeObjectsPerformSelector:(SEL)aSelector;
- (void)threadSafe_makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument;
- (NSSet *)threadSafe_setByAddingObject:(id)anObject NS_AVAILABLE(10_5, 2_0);
- (NSSet *)threadSafe_setByAddingObjectsFromSet:(NSSet *)other NS_AVAILABLE(10_5, 2_0);
- (NSSet *)threadSafe_setByAddingObjectsFromArray:(NSArray *)other NS_AVAILABLE(10_5, 2_0);

#pragma mark NSMutableSet
- (void)threadSafe_addObject:(id)object;
- (void)threadSafe_removeObject:(id)object;
- (void)threadSafe_addObjectsFromArray:(NSArray *)array;
- (void)threadSafe_intersectSet:(NSSet *)otherSet;
- (void)threadSafe_minusSet:(NSSet *)otherSet;
- (void)threadSafe_removeAllObjects;
- (void)threadSafe_unionSet:(NSSet *)otherSet;
- (void)threadSafe_setSet:(NSSet *)otherSet;

@end
