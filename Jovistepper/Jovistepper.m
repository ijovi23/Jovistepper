//
//  Jovistepper.m
//
//  Created by Jovi on 15/8/28.
//  Copyright (c) 2015年 Jovistudio All rights reserved.
//

#import "Jovistepper.h"

@interface Jovistepper ()<UITextFieldDelegate>{
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
    }
    return self;
}

- (instancetype)initWithValue:(NSInteger)value minValue:(NSInteger)min maxValue:(NSInteger)max{
    self = [super init];
    if (self) {
        _oldValue = NSIntegerMin;
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
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setCornerRadius:0];
    [self.layer setBorderWidth:0.5];
    [self.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [_textValue setDelegate:self];
    _maxValue = StepperDefaultMaxValue;
    _minValue = StepperDefaultMinValue;
    [self updateValueToTextField];
}

- (void)setTouchEnabled:(BOOL)isEnabled{
    [self setUserInteractionEnabled:isEnabled];
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
    [_textValue setText:[NSString stringWithFormat:@"%ld", _value]];
    if (_value != _oldValue) {
        if (_delegate != nil) {
            if ([_delegate respondsToSelector:@selector(stepper:valueChanged:)]) {
                [_delegate stepper:self valueChanged:_value];
            }
            if (_value > _oldValue && [_delegate respondsToSelector:@selector(stepper:valueIncreased:)]) {
                [_delegate stepper:self valueIncreased:_value];
            }else if (_value < _oldValue && [_delegate respondsToSelector:@selector(stepper:valueDecreased:)]){
                [_delegate stepper:self valueDecreased:_value];
            }
        }
        _oldValue = _value;
    }
}

- (void)updateValueFromTextField{
    NSInteger v = [_textValue.text integerValue];
    if (v < _minValue){
        v = _minValue;
    }else if (v > _maxValue){
        v = _maxValue;
    }
    _value = v;
    [self updateValueToTextField];
}

- (IBAction)btnPlusPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(stepperButtonPlusPressed:)]) {
        [_delegate stepperButtonPlusPressed:self];
    }
    _value ++;
    if (_value > _maxValue){
        _value = _maxValue;
        return;
    }
    [self updateValueToTextField];
    if ([_textValue isFirstResponder]) {
        [_textValue resignFirstResponder];
    }
}

- (IBAction)btnMinusPressed:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(stepperButtonMinusPressed:)]) {
        [_delegate stepperButtonMinusPressed:self];
    }
    _value --;
    if (_value < _minValue){
        _value = _minValue;
        return;
    }
    [self updateValueToTextField];
    if ([_textValue isFirstResponder]) {
        [_textValue resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(stepper:fieldDidBeginEditing:)]) {
        [_delegate stepper:self fieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self updateValueFromTextField];
    if (_delegate && [_delegate respondsToSelector:@selector(stepper:fieldDidEndEditing:)]) {
        [_delegate stepper:self fieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self updateValueFromTextField];
    [textField resignFirstResponder];
    return YES;
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
