//
//  NSFileManager+DoNotBackup.h
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 08.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

@interface NSFileManager (DoNotBackup)

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end
