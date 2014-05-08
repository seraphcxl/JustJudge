//
//  NSObject+GCDThreadSafe.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/8/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCDThreadSafe)

- (id)threadSafe_init;
- (BOOL)threadSafe_QueueSync:(dispatch_block_t) block;
- (BOOL)threadSafe_QueueBarrierAsync:(dispatch_block_t) block;

@end
