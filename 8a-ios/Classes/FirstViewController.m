//
//  FirstViewController.m
//  8a-ios
//
//  Created by Alex Zhang on 21/04/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){

    IBOutlet UIButton *watchBtn;
    IBOutlet UIButton *reportBtn;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add border
    [Utils roundView:watchBtn];
    [Utils roundView:reportBtn];
}

- (IBAction)watchButtonClicked:(UIButton *)sender {
    [ProgressHUD showError:@"Pending!"];
}

- (IBAction)reportButtonClicked:(UIButton *)sender {
    
    //TODO: check validation
    
    //go to ConfirmViewNextController
    [self performSegueWithIdentifier:@"segue_firstToConfirm" sender:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
