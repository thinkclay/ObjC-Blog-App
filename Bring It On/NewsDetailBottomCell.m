//
//  NewsDetailBottomCell.m
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 15.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import "NewsDetailBottomCell.h"

@implementation NewsDetailBottomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        self.textView = [[UIWebView alloc] initWithFrame:CGRectMake(5.0, 0.0, 307.0, self.contentView.bounds.size.height)];
        [self.textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        self.textView.dataDetectorTypes = UIDataDetectorTypeNone; //UIDataDetectorTypeAll;
        self.textView.opaque = NO;
		self.textView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
