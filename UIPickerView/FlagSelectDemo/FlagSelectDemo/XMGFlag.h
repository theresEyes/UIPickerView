//
//  XMGFlag.h
//  
//
//  Created by zhangqi on 8/3/2016.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XMGFlag : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) UIImage *icon;

+ (instancetype)flageWithDict:(NSDictionary *)dict;
@end
