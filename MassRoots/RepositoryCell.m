//
//  ExploreCollectionCell.h
//
//  Created by Ryan Tuttle
//

#import "RepositoryCell.h"

@implementation RepositoryCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
         // Initialization code
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        CGFloat screenWidth = screenSize.width;
        
        self.avatarImage = [[UIImageView alloc]init];
        self.avatarImage.frame = CGRectMake( 20.0f, 20.0f, 60, 60);
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = CGRectMake(100, 20, 140, 25);
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.ownerLabel = [[UILabel alloc]init];
        self.ownerLabel.frame = CGRectMake(100, 45, 80, 20);
        [[self ownerLabel] setTextColor:[UIColor grayColor]];
        [[self ownerLabel] setFont:[UIFont systemFontOfSize:12]];
        
        self.updatedLabel = [[UILabel alloc]init];
        self.updatedLabel.frame = CGRectMake(screenWidth-130, 25, 80, 20);
        [[self updatedLabel] setTextColor:[UIColor grayColor]];
        [[self updatedLabel] setFont:[UIFont systemFontOfSize:10]];
        
        self.languageLabel = [[UILabel alloc]init];
        self.languageLabel.frame = CGRectMake(100, 65, 80, 20);
        [[self languageLabel] setTextColor:[UIColor grayColor]];
        [[self languageLabel] setFont:[UIFont systemFontOfSize:12]];
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        self.summaryLabel = [[UILabel alloc]init];
        self.summaryLabel.frame = CGRectMake(20, 80, screenWidth - 40, 80);
        [[self summaryLabel] setTextColor:[UIColor darkGrayColor]];
        [[self summaryLabel] setFont:[UIFont systemFontOfSize:12]];
        self.summaryLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.summaryLabel.numberOfLines = 4;
        self.summaryLabel.adjustsFontSizeToFitWidth = YES;
        
        
        self.starRepoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.starRepoBtn.frame = CGRectMake(20, 165, 90, 30);
        [self.starRepoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.starRepoBtn setTitle:NSLocalizedString(@"Star Repo",nil) forState:UIControlStateNormal];
        self.starRepoBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.starRepoBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.starRepoBtn.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0];
        self.starRepoBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:self.starRepoBtn];
        [self.contentView addSubview:self.avatarImage];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.ownerLabel];
        [self.contentView addSubview:self.updatedLabel];
        [self.contentView addSubview:self.summaryLabel];
        [self.contentView addSubview:self.languageLabel];
    }
    return self;
}



@end
