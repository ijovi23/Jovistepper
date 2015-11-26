//
//  Jovistepper.h
//
//  Created by Jovi on 15/8/28.
//  Copyright (c) 2015年 Jovistudio All rights reserved.
//

#import <UIKit/UIKit.h>

#define StepperDefaultMaxValue 9999
#define StepperDefaultMinValue 0

@interface Jovistepper : UIControl
@property (weak, nonatomic) UIButton *btnPlus;
@property (weak, nonatomic) UIButton *btnMinus;
@property (weak, nonatomic) UIButton *btnValue;

/**
 *  Current Value
 */
@property (assign, nonatomic) NSInteger value;

/**
 *  Maximum Value
 */
@property (assign, nonatomic) NSInteger maxValue;

/**
 *  Minimum Value
 */
@property (assign, nonatomic) NSInteger minValue;

@property (strong, nonatomic) UIColor *backgroundColorForButtonPlusAndMinus;

@property (strong, nonatomic) UIColor *backgroundColorForButtonValue;

@property (strong, nonatomic) UIFont *fontForButtonPlusAndMinus;

@property (strong, nonatomic) UIFont *fontForButtonValue;

@property (strong, nonatomic) UIColor *titleColorForButtonPlusAndMinus;

@property (strong, nonatomic) UIColor *titleColorForButtonValue;

@property (strong, nonatomic) NSString *inputViewTitle;
@property (strong, nonatomic) NSString *inputViewCancelTitle;
@property (strong, nonatomic) NSString *inputViewConfirmTitle;

/**
 *  Delegate
 */
//@property (weak, nonatomic) id<JovistepperDelegate> delegate;

- (instancetype)initWithValue:(NSInteger)value minValue:(NSInteger)min maxValue:(NSInteger)max;
- (void)setValue:(NSInteger)value;

@end