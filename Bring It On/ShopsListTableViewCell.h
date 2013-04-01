//
//  ShopsListTableViewCell.h
//  ABusinessTemplate
//
//  Created by Oliver Kiessler on 15.08.12.
//  Copyright (c) 2012 Oliver Kiessler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shop.h"

@interface ShopsListTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIImageView *lineImageView;
@property (strong, nonatomic) UIButton *phoneButton;
@property (strong, nonatomic) UIButton *websiteButton;

@property (weak, nonatomic) Shop *shopItem;

-(void)call;
-(void)openWebsite;

@end
