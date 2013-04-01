#import "Stylesheet.h"

@implementation Stylesheet

+(UIColor*)headerLabelShadowColor {
    return [UIColor colorFromRGBIntegers:171 green:106 blue:40 alpha:1.0];
}

+(UIColor*)labelShadowColor {
    return [UIColor whiteColor];
}

+(UIColor*)darkTextColor {
    return [UIColor colorFromRGBIntegers:93 green:92 blue:92 alpha:1.0];
}

+(UIColor*)lightTextColor {
    return [UIColor colorFromRGBIntegers:196 green:196 blue:196 alpha:1.0];
}

+(UIColor*)highlightTextColor {
    return [UIColor colorFromRGBIntegers:43 green:182 blue:179 alpha:1.0];
}

+(UIFont*)largeFont {
    return [UIFont fontWithName:@"OpenSans-CondensedBold" size:18.0f];
}

+(UIFont*)midsizeFont {
    return [UIFont fontWithName:@"OpenSans-CondensedBold" size:16.0f];
}

+(UIFont*)smallFont {
    return [UIFont fontWithName:@"OpenSans-CondensedBold" size:14.0f];
}

+(UIFont*)tinyFont {
    return [UIFont fontWithName:@"OpenSans-CondensedBold" size:12.0f];
}

+(UIFont*)mapFont {
    return [UIFont fontWithName:@"OpenSans-CondensedBold" size:16.0f];
}

@end
