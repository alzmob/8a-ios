//
//  ConfirmNextViewController.m
//  8a-ios
//
//  Created by Alex Zhang on 21/04/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ConfirmNextViewController.h"
#import "ProfileViewController.h"

@interface ConfirmNextViewController () <UITextFieldDelegate> {
    IBOutlet UIButton *nextBtn;
    IBOutlet UIButton *notReceiveBtn;
    IBOutlet UITextField *codeTxtFld;
    IBOutlet UILabel *reportLabel;
    
    NSString *token;
}

@end

@implementation ConfirmNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Utils roundView:nextBtn];
    [Utils roundView:notReceiveBtn];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)nextButtonClicked:(UIButton *)sender {
    
    [reportLabel setHidden:YES];
    
    NSString *code = codeTxtFld.text;
    if (code == nil || code.length < 6) {
        [ProgressHUD showError:@"Please enter valid code.\n ex:028-385"];
        return;
    }
    
    [ProgressHUD show:@""];
    
    //call API for login
    [[APIManager shared] loginWithPhoneNumber:self.phonenumber confirmationCode:code withCompletion:^(BOOL success, id res) {
        [ProgressHUD dismiss];
        if (success) {
            token = res[@"token"];
            NSLog(@"token:%@", token);
            [self goProfileVC];
        }else {
            [reportLabel setHidden:NO];
        }
    }];
}

- (IBAction)notReceiveButtonClicked:(UIButton *)sender {
    
    //go to previous viewController
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goProfileVC {
    [self performSegueWithIdentifier:@"segue_nextToProfile" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue_nextToProfile"]) {
        ProfileViewController *vc = [segue destinationViewController];
        vc.token = token;
    }
}

@end
