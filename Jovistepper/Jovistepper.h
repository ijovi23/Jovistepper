//
//  Jovistepper.h
//
//  Created by Jovi on 15/8/28.
//  Copyright (c) 2015年 Jovistudio All rights reserved.
//

#import <UIKit/UIKit.h>

#define StepperDefaultMaxValue 9999
#define StepperDefaultMinValue 1

@class Jovistepper;

@protocol CustomStepperDelegate <NSObject>

@required
- (void)stepper: (Jovistepper*)stepper valueChanged:(NSInteger)value;

@optional
- (void)stepper:(Jovistepper *)stepper valueIncreased:(NSInteger)value;
- (void)stepper:(Jovistepper *)stepper valueDecreased:(NSInteger)value;
- (void)stepperButtonPlusPressed:(Jovistepper *)stepper;
- (void)stepperButtonMinusPressed:(Jovistepper *)stepper;
@end


@interface Jovistepper : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnPlus;
@property (weak, nonatomic) IBOutlet UIButton *btnMinus;
@property (weak, nonatomic) IBOutlet UITextField *textValue;
@property (assign, nonatomic) NSInteger value;
@property (assign, nonatomic) NSInteger maxValue;
@property (assign, nonatomic) NSInteger minValue;
@property (strong, nonatomic) id<CustomStepperDelegate> delegate;

- (instancetype)init;
- (instancetype)initWithValue:(NSInteger)value minValue:(NSInteger)min maxValue:(NSInteger)max;
- (void)setValue:(NSInteger)value;
- (void)setTouchEnabled:(BOOL)isEnabled;

@end