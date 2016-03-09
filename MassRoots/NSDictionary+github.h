//
//  NSDictionary+github.h
//  MassRoots
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 Code With Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (github)

- (NSString *)title;
- (NSString *)summary;
- (NSString *)language;
- (NSString *)ownerName;
- (NSString *)ownerAvatar;
- (NSString *)updated;
- (NSString *)htmlURL;

@end
