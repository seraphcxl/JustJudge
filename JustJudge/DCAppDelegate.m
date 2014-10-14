//
//  DCAppDelegate.m
//  JustJudge
//
//  Created by Derek Chen on 5/8/14.
//  Copyright (c) 2014 Derek Chen. All rights reserved.
//

#import "DCAppDelegate.h"

#import "DCFileMonitor.h"

@implementation DCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"%s", __BASE_FILE__);
    NSLog(@"%s", __DATE__);
    NSLog(@"%s", __FILE__);
    NSLog(@"%s", __func__);
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%d", __LINE__);
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"%s", __TIME__);
    NSLog(@"%s", __TIMESTAMP__);
    NSLog(@"%s", __VERSION__);
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dir = [NSString stringWithFormat:@"%@/Music", [paths objectAtIndex:0]];
    
    [[DCFileMonitor sharedDCFileMonitor] watch:dir recursively:YES onlyDirectory:YES  withHandler:^(NSString *path, dispatch_source_vnode_flags_t flags) {
        NSLog(@"File Monitor fired. path:%@ flags:%lu", path, flags);
    }];
    
    NSArray *tmpAry = [[DCFileMonitor sharedDCFileMonitor] watchList];
    for (NSString *str in tmpAry) {
        NSLog(@"%@", str);
    }
    
    [[DCFileMonitor sharedDCFileMonitor] stopWatch:dir recursively:NO];
    
    NSLog(@"%@", [[DCFileMonitor sharedDCFileMonitor] watchList]);
}

@end
