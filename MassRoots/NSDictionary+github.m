//
//  NSDictionary+github.h
//  MassRoots
//
//  Created by Ryan on 3/08/16.
//

#import "NSDictionary+github.h"

@implementation NSDictionary (github)


- (NSString *)title
{
    return self[@"name"];
}

-(NSString *)summary
{
    return self[@"description"];
}

-(NSString *)language
{
    return self[@"languages_url"];
}

- (NSString *)ownerName
{
    NSDictionary *dict = self[@"owner"];
    return dict[@"login"];
}

- (NSString *)ownerAvatar
{
    NSDictionary *dict = self[@"owner"];
    return dict[@"avatar_url"];
}

- (NSString *)updated
{
    return self[@"updated_at"];
}

- (NSString *)htmlURL
{
    return self[@"html_url"];
}

@end