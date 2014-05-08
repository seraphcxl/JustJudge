//
//  NSMutableArray+GCDThreadSafe.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/7/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GCDThreadSafe.h"

@interface NSMutableArray (GCDThreadSafe)

#pragma mark NSArray
- (NSUInteger)threadSafe_count;
- (id)threadSafe_objectAtIndex:(NSUInteger)index;
- (NSUInteger)threadSafe_indexOfObject:(id)anObject;
#if NS_BLOCKS_AVAILABLE
- (NSArray *)threadSafe_sortedArrayUsingComparator:(NSComparator)cmptr;
- (NSArray *)threadSafe_sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

#pragma mark NSMutableArray
- (void)threadSafe_addObject:(id)anObject;
- (void)threadSafe_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)threadSafe_removeLastObject;
- (void)threadSafe_removeObjectAtIndex:(NSUInteger)index;
- (void)threadSafe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)threadSafe_addObjectsFromArray:(NSArray *)otherArray;
- (void)threadSafe_removeAllObjects;
- (void)threadSafe_removeObject:(id)anObject inRange:(NSRange)range;
- (void)threadSafe_removeObject:(id)anObject;
- (void)threadSafe_removeObjectsInArray:(NSArray *)otherArray;
- (void)threadSafe_removeObjectsInRange:(NSRange)range;
#if NS_BLOCKS_AVAILABLE
- (void)threadSafe_sortUsingComparator:(NSComparator)cmptr;
- (void)threadSafe_sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
#endif

@end
