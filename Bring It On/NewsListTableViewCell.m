//
//  NewsListTableViewCell.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 08.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "NewsListTableViewCell.h"
#import "Stylesheet.h"

@implementation NewsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 22.0, 300.0, 21.0)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [Stylesheet largeFont];
        self.titleLabel.textColor = [Stylesheet darkTextColor];
        self.titleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.titleLabel.shadowOffset = CGSizeMake(1, 1);
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel.autoresizesSubviews = YES;
        [self.contentView addSubview:self.titleLabel];

        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 40.0, 320.0, 20.0)];
        self.subTitleLabel.font = [Stylesheet tinyFont];
        self.subTitleLabel.textColor = [Stylesheet lightTextColor];
        self.subTitleLabel.shadowColor = [Stylesheet labelShadowColor];
        self.subTitleLabel.shadowOffset = CGSizeMake(1, 1);
        self.subTitleLabel.backgroundColor = [UIColor clearColor];
        self.subTitleLabel.textAlignment = UITextAlignmentCenter;
        self.subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.subTitleLabel.autoresizesSubviews = YES;
        [self.contentView addSubview:self.subTitleLabel];

        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 73.0, 340.0, 3.0)];
        self.lineImageView.clipsToBounds = YES;
        self.lineImageView.image = [UIImage imageNamed:@"Line"];
        self.lineImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.lineImageView.autoresizesSubviews = YES;
        [self.contentView addSubview:self.lineImageView];

        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DetailIndicator"]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (selected) {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DetailIndicatorActive"]];
    } else {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DetailIndicator"]];
    }
}

@end
