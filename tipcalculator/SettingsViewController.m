//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Ning Liang on 2/25/14.
//  Copyright (c) 2014 Ning Liang. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (void) loadDefaultTipPercentage;
- (IBAction)onTipControlChange:(id)sender;

// Static methods so we can access default tip percentage from other controllers
+ (float) getDefaultTipPercentage;
+ (void) setDefaultTipPercentage:(float)defaultTipPercentage;
+ (NSInteger) tipControlIndexFor:(float)tipPercentage;
+ (float) tipPercentageFor:(NSInteger)index;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDefaultTipPercentage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDefaultTipPercentage {
    float defaultTipPercentage = [SettingsViewController getDefaultTipPercentage];
    
    NSInteger index = [SettingsViewController tipControlIndexFor:defaultTipPercentage];
    self.tipControl.selectedSegmentIndex = index;
}

- (IBAction)onTipControlChange:(id)sender {
    float tipPercentage = [SettingsViewController tipPercentageFor:self.tipControl.selectedSegmentIndex];
    [SettingsViewController setDefaultTipPercentage:tipPercentage];
}

+ (float) getDefaultTipPercentage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    float tipPercentage = [defaults floatForKey:@"defaultTipPercentage"];
    if (tipPercentage == (float)0.0) {
        tipPercentage = 0.1;
        [SettingsViewController setDefaultTipPercentage:tipPercentage];
    }
    return tipPercentage;
}

+ (void) setDefaultTipPercentage:(float)defaultTipPercentage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:defaultTipPercentage forKey:@"defaultTipPercentage"];
    [defaults synchronize];
}

// TODO handle invalid input
+ (NSInteger) tipControlIndexFor:(float)tipPercentage {
    if (tipPercentage == (float)0.1) {
        return 0;
    } else if (tipPercentage == (float)0.15) {
        return 1;
    } else {
        return 2;
    }
}

// TODO handle invalid input
+ (float) tipPercentageFor:(NSInteger)index {
    if (index == 0) {
        return 0.1;
    } else if (index == 1) {
        return 0.15;
    } else {
        return 0.2;
    }
}

@end
