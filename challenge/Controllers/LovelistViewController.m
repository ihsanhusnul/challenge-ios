//
//  LovelistViewController.m
//  challenge
//
//  Created by ihsan husnul on 10/21/17.
//  Copyright © 2017 IHsan HUsnul. All rights reserved.
//

#import "LovelistViewController.h"
#import "LovelistModelView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface LovelistViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *datasource;
    
    __weak IBOutlet UILabel *emptyStateLbl;
    __weak IBOutlet UITableView *lovelistTableView;
}

@end

@implementation LovelistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapBack:)];
    self.navigationItem.leftBarButtonItem = backbtn;
    
    datasource = [NSMutableArray new];
    
    [self requestLovelist];
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

- (void)requestLovelist {
    [SVProgressHUD show];
    [LovelistModelView requestLovelistWithToken:true completionHandler:^(NSDictionary *response, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        else {
            datasource = response[@"_data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [lovelistTableView reloadData];
            });
        }
    }];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (datasource.count != 0)
        [emptyStateLbl setHidden:YES];
    
    return datasource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    
    NSDictionary *item = datasource[indexPath.row];
    
    if ([item[@"display_picts"] isKindOfClass:[NSArray class]]) {
        UIImageView *imgView = [cell viewWithTag:1];
        [imgView setImageWithURL:[NSURL URLWithString:item[@"display_picts"][0]]];
    }
    
    UILabel *titleLbl = [cell viewWithTag:2];
    [titleLbl setText:item[@"name"]];
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setCurrencySymbol:@"Rp"];
    [format setCurrencyDecimalSeparator:@"."];
    
    UILabel *priceLbl = [cell viewWithTag:3];
    [priceLbl setText:[NSString stringWithFormat:@"Rp %@", [format stringFromNumber:item[@"price"]]]];
    
    return cell;
}
@end
