//
//  ViewController.m
//  点餐系统Demo
//
//  Created by zhangqi on 8/3/2016.
//  Copyright (c) 2016 zhangqi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *fruitLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *dringkLabel;


@property (nonatomic,strong)NSArray *foods;
@end

@implementation ViewController

- (NSArray *)foods
{
    if (_foods == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        _foods = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _foods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    // 初始化label标题
    
    for (int i = 0; i < 3; i++) {
        
        [self pickerView:nil didSelectRow:0 inComponent:i];
        
    }

}

#pragma mark --UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}

// returns the # of rows in each component..
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.foods[component] count];
}

#pragma mark --UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            // 设置水果
            _fruitLabel.text = self.foods[component][row];
            break;
        case 1:
            // 设置主食
            _mainLabel.text = self.foods[component][row];
            break;
        case 2:
            // 设置饮料
            _dringkLabel.text = self.foods[component][row];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
