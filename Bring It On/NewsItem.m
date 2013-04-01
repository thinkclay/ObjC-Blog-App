#import "NewsItem.h"

@implementation NewsItem

+(NSMutableArray*)loadNewsItems {
    LogMethod();
    NSMutableArray *newsItems = [[NSMutableArray alloc] init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/news_items.plist", documentsDirectory];
	
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:filePath]) {
        NSLog(@"Creating initial version of the news_items.plist file...");
        [newsItems writeToFile:filePath atomically:YES];
        [fileMgr addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:filePath isDirectory:NO]];
    } else {
        NSMutableArray *dicts = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        for (NSDictionary *dict in dicts) {
            NewsItem *newsItem = [NewsItem fromDictionary:dict];
            [newsItems addObject:newsItem];
        }
    }

    return newsItems;
}

+(void)saveNewsItems:(NSArray *)newsItems {
    LogMethod();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/news_items.plist", documentsDirectory];

    NSMutableArray *itemsToSave = [[NSMutableArray alloc] init];
    for (NewsItem *item in newsItems) {
        [itemsToSave addObject:[item toDictionary]];
    }

    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([itemsToSave writeToFile:filePath atomically:YES]) {
        [fileMgr addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:filePath isDirectory:NO]];
    } else {
        NSLog(@"Couldn't save file...");
    }
}

-(NSMutableDictionary*)toDictionary {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.title forKey:@"title"];
    [dict setObject:self.title forKey:@"headline"];
    [dict setObject:self.author forKey:@"author"];
    if (self.detailImageName != nil) {
        [dict setObject:self.detailImageName forKey:@"detailImageName"];
    }
    if (self.imageUrl != nil) {
        [dict setObject:self.imageUrl forKey:@"imageUrl"];
    }
    [dict setObject:self.text forKey:@"text"];
    if (self.url != nil) {
        [dict setObject:self.url forKey:@"url"];
    }
    [dict setObject:self.date forKey:@"date"];
    return dict;
}

+(NewsItem*)fromDictionary:(NSDictionary*)dict {
    NewsItem *newsItem = [[NewsItem alloc] init];
    
    if (dict != nil) {
        newsItem.title = [dict objectForKey:@"title"];
        newsItem.headline = [dict objectForKey:@"headline"];
        newsItem.author = [dict objectForKey:@"author"];
        newsItem.imageUrl = [dict objectForKey:@"imageUrl"];
        newsItem.detailImageName = [dict objectForKey:@"detailImageName"];
        newsItem.text = [dict objectForKey:@"text"];
        newsItem.url = [dict objectForKey:@"url"];
        newsItem.date = [dict objectForKey:@"date"];
    }
    
    return newsItem;
}

@end

