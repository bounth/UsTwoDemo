//
//  UTAUDConverterViewController.m
//  UsTwoDemo
//
//  Created by Marc B on 24/09/15.
//  Copyright © 2015 Marc Bounthong. All rights reserved.
//

#import "UTAUDConverterViewController.h"
#import "UTConverter.h"

@interface UTAUDConverterViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *fieldAUD;
@property (nonatomic, weak) IBOutlet UILabel *labelConverted;
@property (nonatomic, weak) IBOutlet UIButton *buttonDismiss;

@end

@implementation UTAUDConverterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)didClickOnDismissButton:(id)sender {
    [self.fieldAUD resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.labelConverted.text = textField.text;
}

@end
