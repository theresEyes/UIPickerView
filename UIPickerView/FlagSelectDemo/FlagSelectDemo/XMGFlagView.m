//
//  XMGFlagView.m
//  
//
//  Created by zhangqi on 8/3/2016.
//
//

#import "XMGFlagView.h"
@interface XMGFlagView()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation XMGFlagView

- (void)setFlag:(XMGFlag *)flag
{
    _flag = flag;
    _label.text = flag.name;
    _imageView.image = flag.icon;
}

@end
