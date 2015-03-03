//
//  NJWeibo.m
//  06-预习-微博(通过代码自定义cell)
//
//  Created by 李南江 on 14-4-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NJWeibo.h"

@implementation NJWeibo

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (id)weiboWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
