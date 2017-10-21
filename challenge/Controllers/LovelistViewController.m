//
//  LovelistViewController.m
//  challenge
//
//  Created by ihsan husnul on 10/21/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import "LovelistViewController.h"

@interface LovelistViewController ()

@end

@implementation LovelistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapBack:)];
    self.navigationItem.leftBarButtonItem = backbtn;
}
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
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

#pragma mark - IBAction
- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
