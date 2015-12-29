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
@property (weak, nonatomic, readonly) UIButton *btnPlus;
@property (weak, nonatomic, readonly) UIButton *btnMinus;
@property (weak, nonatomic, readonly) UIButton *btnValue;

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
 *  When you set a value which is out of stepper's range, this block will be called;
 */
@property (copy, nonatomic) void (^outOfRangeBlock)(NSInteger ex_value, BOOL isGreater);

/**
 *  If you add steppers in UITableViewCells, this property'd be useful :)
 */
@property (strong, nonatomic) NSIndexPath *indexPath;

- (instancetype)initWithValue:(NSInteger)value minValue:(NSInteger)min maxValue:(NSInteger)max;

@end