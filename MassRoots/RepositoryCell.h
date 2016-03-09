//
//  RepositoryCell.h
//  MassRoots
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 Code With Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoryCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (strong, nonatomic) UILabel *ownerLabel;
@property (strong, nonatomic) UILabel *updatedLabel;
@property (strong, nonatomic) UILabel *languageLabel;
@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UIButton *starRepoBtn;

@end
