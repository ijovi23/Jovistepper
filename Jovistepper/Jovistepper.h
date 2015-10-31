//
//  Jovistepper.h
//
//  Created by Jovi on 15/8/28.
//  Copyright (c) 2015年 Jovistudio All rights reserved.
//

#import <UIKit/UIKit.h>

#define StepperDefaultMaxValue 9999
#define StepperDefaultMinValue 0

@class Jovistepper;

@protocol JovistepperDelegate <NSObject>
@optional
- (void)stepper:(Jovistepper*)stepper valueChanged:(NSInteger)value;
- (void)stepper:(Jovistepper *)stepper valueIncreased:(NSInteger)value;
- (void)stepper:(Jovistepper *)stepper valueDecreased:(NSInteger)value;
- (void)stepper:(Jovistepper *)stepper fieldDidBeginEditing:(UITextField*)textField;
- (void)stepper:(Jovistepper *)stepper fieldDidEndEditing:(UITextField*)textField;
- (void)stepperButtonPlusPressed:(Jovistepper *)stepper;
- (void)stepperButtonMinusPressed:(Jovistepper *)stepper;
@end


@interface Jovistepper : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property (weak, nonatomic) IBOutlet UIButton *btnMinus;
@property (weak, nonatomic) IBOutlet UITextField *textValue;

/**
 *  当前显示的值
 */
@property (assign, nonatomic) NSInteger value;

/**
 *  最大值
 */
@property (assign, nonatomic) NSInteger maxValue;

/**
 *  最小值
 */
@property (assign, nonatomic) NSInteger minValue;

/**
 *  代理
 */
@property (weak, nonatomic) id<JovistepperDelegate> delegate;

//- (instancetype)init;
//- (instancetype)initWithValue:(NSInteger)value minValue:(NSInteger)min maxValue:(NSInteger)max;
// Please Init With: [[[NSBundle mainBundle]loadNibNamed:@"Jovistepper" owner:self options:nil]firstObject]
- (void)setValue:(NSInteger)value;
- (void)setTouchEnabled:(BOOL)isEnabled;

@end