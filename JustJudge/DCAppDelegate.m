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
    // Insert code here to initialize your application
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *dir = [NSString stringWithFormat:@"%@/Music", [paths objectAtIndex:0]];
    
    [[DCFileMonitor sharedDCFileMonitor] watch:dir recursively:YES withHandler:^(NSString *path, dispatch_source_vnode_flags_t flags) {
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
