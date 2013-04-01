#import <Foundation/Foundation.h>
#import "NSFileManager+DoNotBackup.h"

@interface NewsItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *headline;
@property (strong, nonatomic) NSString *detailImageName;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *imageUrl;

// Static Methods
+(NSMutableArray*)loadNewsItems;
+(void)saveNewsItems:(NSArray*)newsItems;
+(NewsItem*)fromDictionary:(NSDictionary*)dict;

// Instance Methods
-(NSMutableDictionary*)toDictionary;

@end
