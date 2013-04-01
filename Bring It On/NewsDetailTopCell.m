//
//  NewsDetailTopCell.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 15.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "NewsDetailTopCell.h"
#import "Stylesheet.h"

@implementation NewsDetailTopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        self.titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 8.0, 320.0, 14.0)];
        self.titleLabel1.backgroundColor = [UIColor clearColor];
        self.titleLabel1.font = [Stylesheet tinyFont];
        self.titleLabel1.textColor = [Stylesheet lightTextColor];
        self.titleLabel1.shadowColor = [Stylesheet labelShadowColor];
        self.titleLabel1.shadowOffset = CGSizeMake(1, 1);
        self.titleLabel1.textAlignment = UITextAlignmentCenter;
        self.titleLabel1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel1.autoresizesSubviews = YES;
        [self.contentView addSubview:self.titleLabel1];
        
        self.titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 24.0, 300.0, 52.0)];
        self.titleLabel2.backgroundColor = [UIColor clearColor];
        self.titleLabel2.font = [Stylesheet largeFont];
        self.titleLabel2.textColor = [Stylesheet darkTextColor];
        self.titleLabel2.shadowColor = [Stylesheet labelShadowColor];
        self.titleLabel2.shadowOffset = CGSizeMake(1, 1);
        self.titleLabel2.textAlignment = UITextAlignmentCenter;
        self.titleLabel2.numberOfLines = 2;
        self.titleLabel2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel2.autoresizesSubviews = YES;
        [self.contentView addSubview:self.titleLabel2];
        
        self.detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12.0, 81.0, 286.0, 131.0)];
        self.detailImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        self.detailImageView.autoresizesSubviews = YES;
        [self.contentView addSubview:self.detailImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
