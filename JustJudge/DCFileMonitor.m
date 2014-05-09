//
//  DCFileMonitor.m
//  Test4FileMonitor
//
//  Created by Derek Chen on 5/6/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCFileMonitor.h"
#import "NSMutableDictionary+GCDThreadSafe.h"

@interface DCFileMonitor () {
}

@property (strong, nonatomic, readonly) NSMutableDictionary *path2Monitor;  // k:(NSString *) v:(dispatch_source_t)

- (NSArray *)_enumSubContents:(NSString *)path onlyDirectory:(BOOL)onlyDirectory;
- (BOOL)_watch:(NSString *)path withHandler:(DCFileMonitorHandler)handler;
- (dispatch_source_t)_getFileMonitor:(NSString *)path;
- (BOOL)_removeFileMonitor:(NSString *)path recursively:(BOOL)recursively;
- (BOOL)_removeFileMonitor:(NSString *)path;

@end

@implementation DCFileMonitor

DEFINE_SINGLETON_FOR_CLASS(DCFileMonitor)

@synthesize path2Monitor = _path2Monitor;

- (id)init {
    self = [super init];
    if (self) {
        _path2Monitor = [[NSMutableDictionary dictionary] threadSafe_init];
    }
    return self;
}

- (NSArray *)watchList {
    __block NSArray *result = nil;
    do {
        result = [self.path2Monitor threadSafe_allKeys];
    } while (NO);
    return result;
}

- (BOOL)watch:(NSString *)path recursively:(BOOL)recursively onlyDirectory:(BOOL)onlyDirectory withHandler:(DCFileMonitorHandler)handler {
    BOOL result = NO;
    do {
        if (!path || !handler) {
            break;
        }
        
        NSString *newPath = [path stringByExpandingTildeInPath];
        
        if (![self _watch:newPath withHandler:handler]) {
            break;
        }
        
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:newPath isDirectory:&isDir]) {
            if (![self _watch:newPath withHandler:handler]) {
                break;
            }
            
            if (isDir) {
                if (recursively) {
                    NSArray *subContentsAry = [self _enumSubContents:path onlyDirectory:onlyDirectory];
                    
                    BOOL failed = NO;
                    for (NSString *subContentPath in subContentsAry) {
                        if (![self _watch:subContentPath withHandler:handler]) {
                            failed = YES;
                            break;
                        }
                    }
                    
                    if (failed) {
                        break;
                    }
                }
            }
        }
    } while (NO);
    return result;
}

- (BOOL)stopWatch:(NSString *)path recursively:(BOOL)recursively {
    BOOL result = NO;
    do {
        if (!path) {
            break;
        }
        
        NSString *newPath = [path stringByExpandingTildeInPath];
        
        if (![self _removeFileMonitor:newPath recursively:recursively]) {
            break;
        }
        
        result = YES;
    } while (NO);
    return result;
}

- (NSArray *)_enumSubContents:(NSString *)path onlyDirectory:(BOOL)onlyDirectory {
    NSMutableArray *result = [NSMutableArray array];
    do {
        if (!path) {
            break;
        }
        
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir] && isDir) {
            NSURL *directoryURL = [NSURL URLWithString:path];
            NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
            
            NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:directoryURL includingPropertiesForKeys:keys  options:(NSDirectoryEnumerationSkipsPackageDescendants | NSDirectoryEnumerationSkipsHiddenFiles) errorHandler:^(NSURL *url, NSError *error) {
                return YES;
            }];
            for (NSURL *url in enumerator) {
                NSString *subPath = [url path];
                if ([[NSFileManager defaultManager] fileExistsAtPath:subPath isDirectory:&isDir]) {
                    if (onlyDirectory && !isDir) {
                        ;
                    } else {
                        [result addObject:[url path]];
                    }
                }
            }
        }
        
    } while (NO);
    return result;
}

- (BOOL)_watch:(NSString *)path withHandler:(DCFileMonitorHandler)handler {
    BOOL result = NO;
    do {
        if (!path || !handler) {
            break;
        }

        dispatch_source_t internalSource = [self _getFileMonitor:path];
        if (!internalSource) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                break;
            }
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            int fileDescriptor = open([path UTF8String], O_EVTONLY);
            if (fileDescriptor < 0) {
                break;
            }
            dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fileDescriptor, (DISPATCH_VNODE_DELETE | DISPATCH_VNODE_WRITE | DISPATCH_VNODE_EXTEND | DISPATCH_VNODE_RENAME), queue);
            dispatch_source_set_event_handler(source, ^{
                unsigned long flags = dispatch_source_get_data(source);
                if (flags) {
                    [self _removeFileMonitor:path];
                    handler(path, flags);
                    if (flags & DISPATCH_VNODE_DELETE) {
                        [self stopWatch:path recursively:YES];
                    } else if (flags & DISPATCH_VNODE_RENAME) {
                        [self stopWatch:path recursively:YES];
                    } else {
                        [self _watch:path withHandler:handler];
                    }
                }
            });
            dispatch_source_set_cancel_handler(source, ^{
                close(fileDescriptor);
            });
            
            [self.path2Monitor threadSafe_setObject:source forKey:path];
            
            dispatch_resume(source);
        }

        result = YES;
    } while (NO);
    return result;
}

- (dispatch_source_t)_getFileMonitor:(NSString *)path {
    __block dispatch_source_t result = nil;
    do {
        if (!path) {
            break;
        }
        
        result = [self.path2Monitor threadSafe_objectForKey:path];
    } while (NO);
    return result;
}

- (BOOL)_removeFileMonitor:(NSString *)path recursively:(BOOL)recursively {
    BOOL result = NO;
    do {
        if (!path) {
            break;
        }
        
        if (recursively) {
            NSArray *internalWatchList = [self watchList];
            
            NSMutableArray *removeDirAry = [NSMutableArray array];
            for (NSString *watchPath in internalWatchList) {
                if ([watchPath hasPrefix:path] && ![watchPath isEqualToString:path]) {
                    [removeDirAry addObject:watchPath];
                }
            }
            
            BOOL failed = NO;
            for (NSString *watchPath in removeDirAry) {
                if (![self _removeFileMonitor:watchPath]) {
                    failed = YES;
                    break;
                }
            }
            
            if (failed) {
                break;
            }
        }
        
        if (![self _removeFileMonitor:path]) {
            break;
        }
        
        result = YES;
    } while (NO);
    return result;
}

- (BOOL)_removeFileMonitor:(NSString *)path {
    BOOL result = NO;
    do {
        if (!path) {
            break;
        }
        
        dispatch_source_t source = [self _getFileMonitor:path];
        if (source) {
            dispatch_source_cancel(source);
            
            [self.path2Monitor threadSafe_removeObjectForKey:path];
        }
        result = YES;
    } while (NO);
    return result;
}

@end
