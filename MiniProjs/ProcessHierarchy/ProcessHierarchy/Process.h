//
//  Process.h
//  ProcessHierarchy
//
//  Created by Ray on 22/08/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Process : NSObject
- (instancetype)initWithName:(NSString*)name children:(NSArray<Process*>*)children;
- (NSString*)dump;
- (NSString*)dumpWithLevel:(int)level andString:(NSString*)str lastProcess:(BOOL)isLastProcess;
- (instancetype)initFromDumpString:(NSString*)dump;
@end
