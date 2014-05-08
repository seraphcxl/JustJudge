//
//  DCFileMonitor.h
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/6/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCSingletonTemplate.h"

typedef void (^DCFileMonitorHandler)(NSString *path, dispatch_source_vnode_flags_t flags);

@interface DCFileMonitor : NSObject

DEFINE_SINGLETON_FOR_HEADER(DCFileMonitor)

- (NSArray *)watchList;
- (BOOL)watch:(NSString *)path recursively:(BOOL)recursively withHandler:(DCFileMonitorHandler)handler;
- (BOOL)stopWatch:(NSString *)path recursively:(BOOL)recursively;

@end
