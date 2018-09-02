//
//  Process.m
//  ProcessHierarchy
//
//  Created by Ray on 22/08/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "Process.h"
@interface Process()
@property (nonatomic) NSString *name;   // 进程名
@property (nonatomic) NSArray<Process *> *children; // 子进程
@end

@implementation Process

- (instancetype)initWithName:(NSString*)name children:(NSArray<Process *> *)children {
    if (self = [super init]) {
        _name = name;
        _children = children;
    }
    return self;
}
- (instancetype)initFromDumpString:(NSString*)dump {
    NSInteger INDENT = 3;
    NSArray* processArray = [dump componentsSeparatedByString:@"\n"];
    int processNumber = 0;
    for(NSString* str in processArray){
        if([str isNotEqualTo:@""]){
            processNumber++;
        }
    }
    NSString* rootProcessName = [processArray firstObject];
    Process* rootProcess;
    if(processNumber == 1){
        rootProcess = [[Process alloc] initWithName:rootProcessName children:nil];
        return rootProcess;
    }else{
        NSMutableArray<Process*>* childrenProcess = nil;
        for(NSInteger i=1; i<processNumber; i++){
            NSInteger lastIndex = 0;
            NSInteger currentIndex = -1;
            NSString* childProcessName;
            NSRange range;
            // 找到进程名称的具体位置和前面缩进位置信息， 返回结果保存在range中，如果没有找到报错并退出
            // 将进程名称保存在lastProcessName，如果此进程包含子进程，对其函数进行递归构建函数调用
            NSRange range_1 = [processArray[i] rangeOfString:@"├─"];
            if(range_1.location != NSNotFound){
                range = range_1;
                currentIndex = range_1.location;
                childProcessName = [processArray[i] substringFromIndex:range_1.location+3];
            }else{
                NSRange range_2 = [processArray[i] rangeOfString:@"└─"];
                if(range_2.location != NSNotFound){
                    range = range_2;
                    currentIndex = range_2.location;
                    childProcessName = [processArray[i] substringFromIndex:range_2.location+3];
                }else{
                    NSLog(@"字符串输入格式有误");
                    return 0;
                }
            }
            
            if(currentIndex == lastIndex){
                // 如果当前进程和上一个进程同级，则先向下检查，如果有多个子进程则递归构建，然后返回当前进程
                // 如果向下检查发现没有子进程，则将此进程添加到可变数组当中
                NSInteger nextIndex = [self findNextIndex:processArray byCurrentPosition:i];
                if(nextIndex == -1 || (nextIndex != -1 && nextIndex == currentIndex)){
                    // 已经为最后一个进程没有下一个进程或子进程，或者下一个进程是并列层级的时候，添加到数组当中
                    Process* currentPocess = [[Process alloc] initWithName: childProcessName children:nil];
                    [childrenProcess addObject:currentPocess];
                }else if(nextIndex == currentIndex+INDENT){
                    // 当前进程包含子进程, 则创建包含多个子进程的进程
                    Process* currentPocess = [self createProcessByName:childProcessName andprocessArray:processArray andCurrentPosition:&i andCurrentIndex:nextIndex];
                    [childrenProcess addObject:currentPocess];
                }
            }
        }
        rootProcess = [[Process alloc] initWithName:rootProcessName children:childrenProcess];
        return rootProcess;
    }
    return nil;
}

- (instancetype)createProcessByName:(NSString*)processName andprocessArray:(NSArray*)processStringArray andCurrentPosition:(NSInteger*)position andCurrentIndex:(NSInteger)currentIndex{
    Process* parentProcess;
    NSMutableArray<Process*>* childrenProcess = [[NSMutableArray alloc] init];
    *position++;
    while(*position+1<[processStringArray count]){
        NSString* childProcessName;
        NSRange range;
        // 找到进程名称的具体位置和前面缩进位置信息， 返回结果保存在range中，如果没有找到报错并退出
        // 将进程名称保存在lastProcessName，如果此进程包含子进程，对其函数进行递归构建函数调用
        NSRange range_1 = [processStringArray[*position] rangeOfString:@"├─"];
        if(range_1.location != NSNotFound){
            range = range_1;
            currentIndex = range_1.location;
            childProcessName = [processStringArray[*position] substringFromIndex:range_1.location+3];
        }else{
            NSRange range_2 = [processStringArray[*position] rangeOfString:@"└─"];
            if(range_2.location != NSNotFound){
                range = range_2;
                currentIndex = range_2.location;
                childProcessName = [processStringArray[*position] substringFromIndex:range_2.location+3];
            }else{
                NSLog(@"字符串输入格式有误");
                return 0;
            }
        }
        NSInteger nextIndex = [self findNextIndex:processStringArray byCurrentPosition:*position+1];
        if(nextIndex == -1 || (nextIndex != -1 && nextIndex == currentIndex)){
            // 已经为最后一个进程没有下一个进程或子进程，或者下一个进程是并列层级的时候，添加到数组当中
            Process* currentPocess = [[Process alloc] initWithName: childProcessName children:nil];
            [childrenProcess addObject:currentPocess];
        }else if(nextIndex == currentIndex+3){
                // 当前进程包含子进程, 则创建包含多个子进程的进程
            Process* currentPocess = [self createProcessByName:childProcessName andprocessArray:processStringArray andCurrentPosition:position andCurrentIndex:nextIndex];
                [childrenProcess addObject:currentPocess];
            }
        *position++;

    }
    return parentProcess;
}

- (NSInteger)findNextIndex:(NSArray*)processStringArray byCurrentPosition:(NSInteger)currentPosition{
    if(currentPosition+1<[processStringArray count]){
        NSRange range;
        NSRange range_1 = [processStringArray[currentPosition+1] rangeOfString:@"├─"];
        if(range_1.location != NSNotFound){
            range = range_1;
        }else{
            NSRange range_2 = [processStringArray[currentPosition+1] rangeOfString:@"└─"];
            if(range_2.location != NSNotFound){
                range = range_2;
            }else{
                NSLog(@"字符串输入格式有误");
                return 0;
            }
        }
        return range.location;
    }else{
        return -1;
    }
}

// 当此进程作为顶级父进程时调用
- (NSString*)dump {
    int level = 0;
    NSString *processHierarchy = [NSString stringWithFormat:@"%@\n",_name];
    if(_children == nil){
        return processHierarchy;
    }else{
        for(Process* childrenProcess in _children){
            if([childrenProcess isEqual:[_children lastObject]]){
                processHierarchy = [processHierarchy stringByAppendingString:[childrenProcess dumpWithLevel:level+1 andString:@"└─" lastProcess:YES]];
            }else{
                processHierarchy = [processHierarchy stringByAppendingString:[childrenProcess dumpWithLevel:level+1 andString:@"├─" lastProcess:NO]];
            }
        }
    }
    return processHierarchy;
}

// 当此进程作为子进程时调用
- (NSString*)dumpWithLevel:(int)level andString:(NSString*)str lastProcess:(BOOL)isLastProcess{
    NSString* PREFIX = [[NSString alloc] init];
    /*
     当此进程为最后一个进程且有多个子进程时前面不加|
     例如一下格式：
     Launcher
     ├─ Finder
     ├─ QQ
     └─ Xcode
        ├─ Simulator
        └─ Debugger
     
     */
    
    /*
     当此进程不为最后一个进程且包含多个子进程时前面追加|
     例如以下格式：
     Launcher
     ├─ Xcode
     │  ├─ Simulator
     │  └─ Debugger
     ├─ Finder
     └─ QQ
     */
    if(isLastProcess == YES){
        PREFIX = @"   ";
    }else{
        PREFIX = @"│  ";
    }
    NSString* childrenProcessName = [NSString stringWithFormat:@"%@ %@\n",str,_name];
    for(int i=0; i<level-1; i++){
        NSString* tempString = [[NSString alloc] init];
        childrenProcessName = [tempString stringByAppendingFormat:@"%@%@",PREFIX,childrenProcessName];
    }
    
    NSString* childrenProcessHierarchy = childrenProcessName;
    if(_children == nil){
        return childrenProcessHierarchy;
    }else{
        for(Process* childrenProcess in _children){
            if([childrenProcess isEqual:[_children lastObject]]){
                childrenProcessHierarchy = [childrenProcessHierarchy stringByAppendingString:[childrenProcess dumpWithLevel:level+1 andString:@"└─" lastProcess:isLastProcess]];
            }else{
                childrenProcessHierarchy = [childrenProcessHierarchy stringByAppendingString:[childrenProcess dumpWithLevel:level+1 andString:@"├─" lastProcess:isLastProcess]];
            }
        }
    }
    
    return childrenProcessHierarchy;
}

@end
