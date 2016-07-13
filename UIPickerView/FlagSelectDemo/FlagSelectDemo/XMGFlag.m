//
//  XMGFlag.m
//  
//
//  Created by zhangqi on 8/3/2016.
//
//

#import "XMGFlag.h"

@implementation XMGFlag

+ (instancetype)flageWithDict:(NSDictionary *)dict
{
    XMGFlag *flag = [[self alloc] init];
    [flag setValuesForKeysWithDictionary:dict];
    return flag;
}

- (void)setIcon:(NSString *)icon
{
    _icon = [UIImage imageNamed:icon];
}
@end
