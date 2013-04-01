#import "GenericTableViewHeader.h"
#import "Stylesheet.h"

@implementation GenericTableViewHeader

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 47.0)];
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.image = [UIImage imageNamed:@"bg_header"];
        self.headerImageView.autoresizesSubviews = YES;
        self.headerImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.headerImageView];
        
        self.headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 15.0, 300.0, 21.0)];
        self.headerTitle.backgroundColor = [UIColor clearColor];
        self.headerTitle.font = [Stylesheet largeFont];
        self.headerTitle.textColor = [UIColor whiteColor];
        self.headerTitle.shadowColor = [Stylesheet headerLabelShadowColor];
        self.headerTitle.shadowOffset = CGSizeMake(1, 1);
        self.headerTitle.textAlignment = UITextAlignmentCenter;
        self.headerTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.headerTitle.autoresizesSubviews = YES;
        [self addSubview:self.headerTitle];
    }
    return self;
}

@end
