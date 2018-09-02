//
//  main.m
//  ProcessHierarchy
//
//  Created by Ray on 22/08/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Process.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Process* xcode = [[Process alloc] initWithName:@"Xcode"
                                              children:@[[[Process alloc] initWithName:@"Simulator" children:nil],
                                                         [[Process alloc] initWithName:@"Debugger" children:nil]]];
        Process* finder = [[Process alloc] initWithName:@"Finder" children:nil];
        Process* qq = [[Process alloc] initWithName:@"QQ" children:nil];
        Process* launcher = [[Process alloc] initWithName:@"Launcher" children:@[xcode, finder, qq]];
        
        NSLog(@"%@", [launcher dump]);
    }
    
    
    NSLog(@"-----通过字符串读入建立进程树-----");
    NSString* processHierarchy_1 = [NSString stringWithFormat:@"Launcher\n├─ Xcode\n│  ├─ Simulator\n│  └─ Debugger\n├─ Finder\n└─ QQ\n"];
    NSLog(@"输入样例1：\n%@",processHierarchy_1);
    Process *processTree = [[Process alloc] initFromDumpString:processHierarchy_1];
    NSLog(@"dump后的到的结果：\n%@",[processTree dump]);
    
    return 0;
}
