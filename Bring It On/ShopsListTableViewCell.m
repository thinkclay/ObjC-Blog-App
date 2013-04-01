//
//  ShopsListTableViewCell.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 15.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "ShopsListTableViewCell.h"
#import "Stylesheet.h"

@implementation ShopsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 15.0, 320.0, 18.0)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [Stylesheet smallFont];
        self.titleLabel.textColor = [Stylesheet darkTextColor];
        self.titleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.titleLabel.shadowOffset = CGSizeMake(1, 1);
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel.autoresizesSubviews = YES;
        [self.contentView addSubview:self.titleLabel];

        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 37.0, 320.0, 20.0)];
        self.subTitleLabel.font = [Stylesheet smallFont];
        self.subTitleLabel.textColor = [Stylesheet darkTextColor];
        self.subTitleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.subTitleLabel.shadowOffset = CGSizeMake(1, 1);
        self.subTitleLabel.backgroundColor = [UIColor clearColor];
        self.subTitleLabel.textAlignment = UITextAlignmentCenter;
        self.subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.subTitleLabel.autoresizesSubviews = YES;
        [self.contentView addSubview:self.subTitleLabel];

        UIImage *buttonImage1 = [[UIImage imageNamed:@"button_light"]
                                    resizableImageWithCapInsets:UIEdgeInsetsMake(4, 5, 4, 5)];
        UIImage *buttonImage2 = [[UIImage imageNamed:@"button_darker"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(4, 5, 4, 5)];
        
        self.phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.phoneButton.frame = CGRectMake(30.0, 62.0, 105.0, 26.0);
        [self.phoneButton setBackgroundImage:buttonImage1 forState:UIControlStateNormal];
        [self.phoneButton setBackgroundImage:buttonImage1 forState:UIControlStateHighlighted];
        [self.phoneButton setTitleColor:[Stylesheet darkTextColor] forState:UIControlStateNormal];
        [self.phoneButton setTitleColor:[Stylesheet highlightTextColor] forState:UIControlStateHighlighted];
        self.phoneButton.titleLabel.font = [Stylesheet smallFont];
        [self.phoneButton setTitleShadowColor:[Stylesheet labelShadowColor] forState:UIControlStateNormal];
        self.phoneButton.titleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.phoneButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        [self.phoneButton addTarget:self action:@selector(call) forControlEvents:UIControlEventTouchUpInside];
        self.phoneButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        self.phoneButton.autoresizesSubviews = YES;
        [self.contentView addSubview:self.phoneButton];
        
        self.websiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.websiteButton.frame = CGRectMake(140.0, 62.0, 148.0, 26.0);
        [self.websiteButton setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
        [self.websiteButton setBackgroundImage:buttonImage2 forState:UIControlStateHighlighted];
        [self.websiteButton setTitleColor:[Stylesheet darkTextColor] forState:UIControlStateNormal];
        [self.websiteButton setTitleColor:[Stylesheet highlightTextColor] forState:UIControlStateHighlighted];
        self.websiteButton.titleLabel.font = [Stylesheet smallFont];
        [self.websiteButton setTitleShadowColor:[Stylesheet labelShadowColor] forState:UIControlStateNormal];
        self.websiteButton.titleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.websiteButton.titleLabel.shadowOffset = CGSizeMake(1, 1);
        [self.websiteButton addTarget:self action:@selector(openWebsite) forControlEvents:UIControlEventTouchUpInside];
        self.websiteButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
        self.websiteButton.autoresizesSubviews = YES;
        [self.contentView addSubview:self.websiteButton];
        
        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 107.0, 340.0, 3.0)];
        self.lineImageView.clipsToBounds = YES;
        self.lineImageView.image = [UIImage imageNamed:@"Line"];
        self.lineImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.lineImageView.autoresizesSubviews = YES;
        [self.contentView addSubview:self.lineImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)call {
    LogMethod();
    NSLog(@"Phone: %@", self.shopItem.phone);

    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", self.shopItem.phone]]];
    }
}

-(void)openWebsite {
    LogMethod();
    NSLog(@"Website: %@", self.shopItem.website);
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", self.shopItem.website]]];
}

@end
