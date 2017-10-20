//
//  LoginViewController.m
//  challenge
//
//  Created by ihsan husnul on 10/21/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () {
    
    __weak IBOutlet UITextField *usernameField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UIButton *loginBtn;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLoginView];
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - local methods
- (void)setLoginView {
    [usernameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [passwordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    loginBtn.layer.borderWidth = 1;
}

#pragma mark - IBAction

@end
