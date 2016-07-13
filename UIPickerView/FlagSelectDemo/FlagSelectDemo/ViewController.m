//
//  ViewController.m
//  FlagSelectDemo
//
//  Created by zhangqi on 8/3/2016.
//  Copyright (c) 2016 zhangqi. All rights reserved.
//

#import "ViewController.h"
#import "XMGFlag.h"
#import "XMGFlagView.h"
@interface ViewController () <UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) NSMutableArray *flags;
@end

@implementation ViewController
- (NSMutableArray *)flags
{
    if (_flags == nil) {
        _flags = [NSMutableArray array];
        
        // 加载plist
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        
        for (NSDictionary *dict in arr) {
            XMGFlag *flag = [XMGFlag flageWithDict:dict];
            [_flags addObject:flag];
        }
    }
    return _flags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

#pragma mark --UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}

#pragma mark --UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    XMGFlagView *flagView = [[NSBundle mainBundle] loadNibNamed:@"XMGFlagView" owner:nil options:nil][0];
    
    XMGFlag *flag = self.flags[row];
    flagView.flag = flag;
    return flagView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
