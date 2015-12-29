//
//  ViewController.m
//  JovistepperDemo
//
//  Created by Jovi on 15/11/26.
//  Copyright © 2015年 Jovistudio. All rights reserved.
//

#import "ViewController.h"
#import "Jovistepper.h"

@interface ViewController ()

@end

@implementation ViewController{
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Jovistepper *stepper = [[Jovistepper alloc]initWithValue:1 minValue:0 maxValue:100];
    [stepper setFrame:CGRectMake(100, 100, 100, 28)];
    [stepper setBackgroundColorForButtonPlusAndMinus:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
    [stepper setBackgroundColorForButtonValue:[UIColor whiteColor]];
    [stepper setTitleColorForButtonPlusAndMinus:[UIColor blackColor]];
    [stepper setTitleColorForButtonValue:[UIColor blackColor]];
    [stepper.layer setBorderWidth:0.5];
    [stepper setInputViewTitle:@"#Input a number"];
    [stepper setInputViewConfirmTitle:@"#OK"];
    [stepper setInputViewCancelTitle:@"#Cancel"];
    [stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
    
    [stepper setOutOfRangeBlock:^(NSInteger ex_value, BOOL isGreater) {
        NSLog(@"Out Of Range! value:%ld greater:%@", ex_value, isGreater?@"Greater":@"Less");
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
    [label setTextColor:[UIColor blackColor]];
    [label setText:[NSString stringWithFormat:@"Stepper:%ld", stepper.value]];
    [self.view addSubview:label];
    _label = label;
}

- (void)stepperValueChanged:(Jovistepper*)stepper{
    [_label setText:[NSString stringWithFormat:@"Stepper:%ld", stepper.value]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
