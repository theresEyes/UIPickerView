//
//  XMGProvince.h
//  
//
//  Created by zhangqi on 8/3/2016.
//
//

#import <Foundation/Foundation.h>

@interface XMGProvince : NSObject
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,strong) NSString *name;

+ (instancetype)provinceWithDict:(NSDictionary *)dict;
@end
