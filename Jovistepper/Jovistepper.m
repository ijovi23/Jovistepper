//
//  Jovistepper.m
//
//  Created by Jovi on 15/8/28.
//  Copyright (c) 2015年 Jovistudio All rights reserved.
//

#import "Jovistepper.h"

@interface Jovistepper () <UIAlertViewDelegate> {
    NSInteger _oldValue;
}

@end

@implementation Jovistepper

- (instancetype)init{
    self = [super init];
    if (self) {
        _maxValue = StepperDefaultMaxValue;
        _minValue = StepperDefaultMinValue;
        _value = _minValue;
        _oldValue = _value;
        
        [self initUI];
    }
    
    return self;
}

- (instancetype)initWithValue:(NSInteger)value minValue:(NSInteger)min maxValue:(NSInteger)max{
    self = [super init];
    if (self) {
        if (max >= min) {
            _minValue = min;
            _maxValue = max;
        }else{
            _minValue = min;
            _maxValue = StepperDefaultMaxValue;
            NSLog(@"CustomStepper Init Warning: max < min");
        }
        if (value < _minValue){
            value = _minValue;
        }else if (value > _maxValue){
            value = _maxValue;
        }
        _value = value;
        _oldValue = _value;
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self setBackgroundColor:[UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1]];
    [self.layer setBorderColor:self.backgroundColor.CGColor];
    [self.layer setBorderWidth:1];
    
    
    UIButton *btnMinus = [[UIButton alloc]init];
    [btnMinus setBackgroundColor:_backgroundColorForButtonPlusAndMinus];
    [btnMinus.titleLabel setFont:_fontForButtonPlusAndMinus];
    [btnMinus setTitleColor:_titleColorForButtonPlusAndMinus forState:UIControlStateNormal];
    [btnMinus setTitle:@"-" forState:UIControlStateNormal];
    [btnMinus addTarget:self action:@selector(btnMinusPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnMinus];
    _btnMinus = btnMinus;
    
    UIButton *btnPlus = [[UIButton alloc]init];
    [btnPlus setBackgroundColor:_backgroundColorForButtonPlusAndMinus];
    [btnPlus.titleLabel setFont:_fontForButtonPlusAndMinus];
    [btnPlus setTitleColor:_titleColorForButtonPlusAndMinus forState:UIControlStateNormal];
    [btnPlus setTitle:@"+" forState:UIControlStateNormal];
    [btnPlus addTarget:self action:@selector(btnPlusPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnPlus];
    _btnPlus = btnPlus;
    
    UIButton *btnValue = [[UIButton alloc]init];
    [btnValue setBackgroundColor:_backgroundColorForButtonValue];
    [btnValue.titleLabel setFont:_fontForButtonValue];
    [btnValue setTitleColor:_titleColorForButtonValue forState:UIControlStateNormal];
    [btnValue setTitle:[NSString stringWithFormat:@"%ld", _value] forState:UIControlStateNormal];
    [btnValue addTarget:self action:@selector(btnValuePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnValue];
    _btnValue = btnValue;
    
    
    [self layoutUI];
}

- (void)layoutUI{
    CGFloat btnWidth = self.frame.size.width / 3.0;
    [_btnMinus setFrame:CGRectMake(0, 0, btnWidth - 1, self.frame.size.height)];
    [_btnValue setFrame:CGRectMake(CGRectGetMaxX(_btnMinus.frame) + 1, 0, btnWidth - 1, self.frame.size.height)];
    [_btnPlus setFrame:CGRectMake(CGRectGetMaxX(_btnValue.frame) + 1, 0, btnWidth, self.frame.size.height)];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self layoutUI];
}

- (void)setValue:(NSInteger)value{
    if (value < _minValue){
        value = _minValue;
    }else if (value > _maxValue){
        value = _maxValue;
    }
    _value = value;
    
    [self updateValueToTextField];
}

- (void)updateValueToTextField{
    [_btnValue setTitle:[NSString stringWithFormat:@"%ld", _value] forState:UIControlStateNormal];
    if (_value != _oldValue) {
        _oldValue = _value;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)btnPlusPressed:(UIButton*)sender {
    _value ++;
    if (_value > _maxValue){
        _value = _maxValue;
        return;
    }
    [self updateValueToTextField];
}

- (void)btnMinusPressed:(UIButton*)sender {
    _value --;
    if (_value < _minValue){
        _value = _minValue;
        return;
    }
    [self updateValueToTextField];
}

- (void)btnValuePressed:(UIButton*)sender{
    [self showInput];
}

- (void)showInput{
    if (!_inputViewTitle) {
        _inputViewTitle = @"";
    }
    if (!_inputViewCancelTitle) {
        _inputViewCancelTitle = @"Cancel";
    }
    if (!_inputViewConfirmTitle) {
        _inputViewConfirmTitle = @"OK";
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        [self showAlertController];
    }else{
        [self showAlertView];
    }
    
}

- (void)showAlertController{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_inputViewTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:_inputViewCancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:_inputViewConfirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf setValue:[alertController.textFields.firstObject.text integerValue]];
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    [[[UIApplication sharedApplication]keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
    
#endif
}

- (void)showAlertView{
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 80000
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:_inputViewTitle message:nil delegate:self cancelButtonTitle:_inputViewCancelTitle otherButtonTitles:_inputViewConfirmTitle, nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [alertView show];
#endif
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self setValue:[[alertView textFieldAtIndex:0].text integerValue]];
    }
}

- (void)setBackgroundColorForButtonPlusAndMinus:(UIColor *)backgroundColorForButtonPlusAndMinus{
    _backgroundColorForButtonPlusAndMinus = backgroundColorForButtonPlusAndMinus;
    [_btnPlus setBackgroundColor:_backgroundColorForButtonPlusAndMinus];
    [_btnMinus setBackgroundColor:_backgroundColorForButtonPlusAndMinus];
}

- (void)setBackgroundColorForButtonValue:(UIColor *)backgroundColorForButtonValue{
    _backgroundColorForButtonValue = backgroundColorForButtonValue;
    [_btnValue setBackgroundColor:_backgroundColorForButtonValue];
}

- (void)setFontForButtonPlusAndMinus:(UIFont *)fontForButtonPlusAndMinus{
    _fontForButtonPlusAndMinus = fontForButtonPlusAndMinus;
    [_btnPlus.titleLabel setFont:_fontForButtonPlusAndMinus];
    [_btnMinus.titleLabel setFont:_fontForButtonPlusAndMinus];
}

- (void)setFontForButtonValue:(UIFont *)fontForButtonValue{
    _fontForButtonValue = fontForButtonValue;
    [_btnValue.titleLabel setFont:_fontForButtonValue];
}

- (void)setTitleColorForButtonPlusAndMinus:(UIColor *)titleColorForButtonPlusAndMinus{
    _titleColorForButtonPlusAndMinus = titleColorForButtonPlusAndMinus;
    [_btnPlus setTitleColor:_titleColorForButtonPlusAndMinus forState:UIControlStateNormal];
    [_btnMinus setTitleColor:_titleColorForButtonPlusAndMinus forState:UIControlStateNormal];
}

- (void)setTitleColorForButtonValue:(UIColor *)titleColorForButtonValue{
    _titleColorForButtonValue = titleColorForButtonValue;
    [_btnValue setTitleColor:_titleColorForButtonValue forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
