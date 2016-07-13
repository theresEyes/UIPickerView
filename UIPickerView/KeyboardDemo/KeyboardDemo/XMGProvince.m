//
//  XMGProvince.m
//  
//
//  Created by zhangqi on 8/3/2016.
//
//

#import "XMGProvince.h"

@implementation XMGProvince
+ (instancetype)provinceWithDict:(NSDictionary *)dict
{
    XMGProvince *p = [[self alloc] init];
    [p setValuesForKeysWithDictionary:dict];
    return p;
}
@end
