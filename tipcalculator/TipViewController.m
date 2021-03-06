//
//  TipViewController.m
//  tipcalculator
//
//  Created by Ning Liang on 2/18/14.
//  Copyright (c) 2014 Ning Liang. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *peopleControl;
@property (weak, nonatomic) IBOutlet UILabel *tipPersonPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPerPersonLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)loadDefaultTipPercentage;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDefaultTipPercentage];
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)loadDefaultTipPercentage {
    float defaultTipPercentage = [SettingsViewController getDefaultTipPercentage];
    
    NSInteger index = [SettingsViewController tipControlIndexFor:defaultTipPercentage];
    self.tipControl.selectedSegmentIndex = index;
    
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    int peopleCount = [self.peopleControl.text intValue];
    if (peopleCount == 0) {
        peopleCount = 1;
    }
    
    float tipPercentage = [SettingsViewController tipPercentageFor:self.tipControl.selectedSegmentIndex];
    
    float tipAmount = billAmount * tipPercentage;
    float tipPerPersonAmount = tipAmount / peopleCount;
    float totalAmount = tipAmount + billAmount;
    float totalPerPersonAmount = totalAmount / peopleCount;

    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.tipPersonPersonLabel.text = [NSString stringWithFormat:@"$%0.2f", tipPerPersonAmount];
    self.totalPerPersonLabel.text = [NSString stringWithFormat:@"$%0.2f", totalPerPersonAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

@end
