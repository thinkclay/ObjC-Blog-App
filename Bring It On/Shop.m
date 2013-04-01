#import "Shop.h"

@implementation Shop

// Overriden to return a custom subtitle in the callout view.
- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@ | %@ %@", self.street, self.zipcode, self.city];;
}

@end
