//
//  SettingsViewController.h
//  tipcalculator
//
//  Created by Ning Liang on 2/25/14.
//  Copyright (c) 2014 Ning Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

+ (float) getDefaultTipPercentage;
+ (NSInteger) tipControlIndexFor:(float)tipPercentage;
+ (float) tipPercentageFor:(NSInteger)index;

@end
