//
//  ProfileViewController.m
//  8a-ios
//
//  Created by Alex Zhang on 21/04/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)logoutButtonClicked:(id)sender {
    //TODO: logout action
    
    //go firstViewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
