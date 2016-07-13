//
//  ViewController.m
//  KeyboardDemo
//
//  Created by zhangqi on 8/3/2016.
//  Copyright (c) 2016 zhangqi. All rights reserved.
//

#import "ViewController.h"
#import "XMGProvince.h"
@interface ViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;

@property (nonatomic,weak) UIDatePicker *datePicker;
@property (nonatomic,weak) UIPickerView *pickerView;

@property (nonatomic,strong) NSMutableArray *provinces;
@property (nonatomic,assign) NSInteger proIndex;


@end

@implementation ViewController

- (NSMutableArray *)provinces
{
    if (_provinces == nil) {
        _provinces = [NSMutableArray array];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dict in arr) {
            XMGProvince *p = [XMGProvince provinceWithDict:dict];
            [_provinces addObject:p];
        }
    }
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _birthdayField.delegate = self;
    _cityField.delegate = self;
    // 自定义生日键盘
    [self setUpBirthdayKeyboard];
    
    // 自定义城市键盘
    [self setUpCityKeyboard];
}
#pragma mark --UITextFieldDelegate
// 是否允许用户输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _birthdayField) {
        [self dateChange:_datePicker];
    }
}

#pragma mark -自定义生日键盘
- (void)setUpBirthdayKeyboard
{
    UIDatePicker *picker = [[UIDatePicker alloc] init];
    _datePicker = picker;
    
    // 设置地区为：中国
    picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    // 设置日期模式
    picker.datePickerMode = UIDatePickerModeDate;
    
    // 坚挺UIDatePicker的滚动
    [picker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    _birthdayField.inputView = picker;
}

#pragma mark -自定义城市键盘
- (void)setUpCityKeyboard
{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    _pickerView = pickerView;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    _cityField.inputView = pickerView;
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    NSLog(@"%@",datePicker.date);
    // 日期装换字符
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    _birthdayField.text = dateStr;
}


#pragma mark --UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) // 描述的是省
    {
        return self.provinces.count;
    }
    else  // 描述的是这个省有多少个城市
    {
        XMGProvince *p = self.provinces[_proIndex];
        return p.cities.count;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        XMGProvince *p = self.provinces[row];
        return p.name;
    }
    else
    {
        XMGProvince *p = self.provinces[_proIndex];
        return p.cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)  // 滚动省会，刷新城市列表
    {
        _proIndex = [pickerView selectedRowInComponent:0];
        [pickerView reloadComponent:1];
    }
    
    XMGProvince *p = self.provinces[_proIndex];
    
    // 获取选中的城市
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    NSString *cityName = p.cities[cityIndex];
    _cityField.text = [NSString stringWithFormat:@"%@ %@",p.name,cityName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
