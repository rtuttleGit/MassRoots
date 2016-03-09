//
//  Repository.h
//  MassRoots
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 Code With Ryan. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Repository : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSString *ownerAvatar;
@property (strong, nonatomic) NSString *updated;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSString *htmlURL;

@end