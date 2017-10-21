//
//  LoginViewController.m
//  challenge
//
//  Created by ihsan husnul on 10/21/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import "LoginViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserModelView.h"

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
- (NSString*)loginValidates {
    NSMutableArray *errors = [NSMutableArray new];
    
    if (usernameField.text.length == 0) {
        [errors addObject:@"- Username tidak boleh kosong."];
    }
    if (usernameField.text.length < 4) {
        [errors addObject:@"- Username minimal 4 karakter."];
    }
    
    if (passwordField.text.length < 6) {
        [errors addObject:@"- Password minimal 6 karakter."];
    }
    
    if (errors.count == 0) {
        return nil;
    }
    else {
        return [errors componentsJoinedByString:@"\n"];
    }
}
- (void)doLoginUser {
    [SVProgressHUD showWithStatus:@"SIlahan Tunggu..."];
    [UserModelView requestLogin:usernameField.text withPassword:passwordField.text completionHandler:^(NSDictionary *response, NSError *error) {
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        else {
            [SVProgressHUD dismiss];
            
            if ([UserModelView userToken]) {
                NSLog(@"%@", [UserModelView userToken]);
                // goto lovelist
            }
        }
    }];
}

#pragma mark - IBAction
- (IBAction)didTapLoginBtn:(id)sender {
    NSString *messages = [self loginValidates];
    
    if (messages) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"Terjadi Kesalahan" message:messages preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [control dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [control addAction:okAction];
        [self presentViewController:control animated:YES completion:nil];
    }
    else {
        [self doLoginUser];
    }
}

@end
