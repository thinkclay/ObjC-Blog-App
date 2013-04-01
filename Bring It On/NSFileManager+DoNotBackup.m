//
//  NSFileManager+DoNotBackup.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 08.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "NSFileManager+DoNotBackup.h"
#include <sys/xattr.h>

@implementation NSFileManager (DoNotBackup)

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    if (&NSURLIsExcludedFromBackupKey == nil) {
        NSLog(@"Setting com.apple.MobileBackup...");
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    } else {
        NSLog(@"Setting NSURLIsExcludedFromBackupKey...");
        return [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:nil];
    }
}

@end
