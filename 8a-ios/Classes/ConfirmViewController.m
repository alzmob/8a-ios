//
//  ConfirmViewController.m
//  8a-ios
//
//  Created by Alex Zhang on 21/04/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ConfirmViewController.h"
#import "ConfirmNextViewController.h"

@interface ConfirmViewController () <UITextFieldDelegate> {

    IBOutlet UIButton *confirmBtn;
    IBOutlet UITextField *phoneTxtFld;
    NSString *phoneNumber;
}

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Utils roundView:confirmBtn];
    
    phoneNumber = @"";
    
}

- (IBAction)getConfirmButtonClicked:(UIButton *)sender {
    
    [phoneTxtFld resignFirstResponder];
    
    //check phone number validation
    phoneNumber = phoneTxtFld.text;
    
    if (phoneNumber == nil || [phoneNumber length] < 8) {
        [ProgressHUD showError:@"Please enter valid phone number!"];
        return;
    }
    //call API for get confirm code
    unichar firstChar = [[phoneTxtFld text] characterAtIndex:0];
    if (firstChar != '+') {
        phoneNumber = [NSString stringWithFormat:@"+%@", phoneNumber];
    }
    
    [ProgressHUD show:@""];
    
    [[APIManager shared] getConfirmationCodeWithPhoneNumber:phoneNumber withCompletion:^(BOOL success, id res) {
        
        [ProgressHUD dismiss];
        
        if (success) {
            if ([res[@"success"] isEqualToString:@"ok"]) {
                NSLog(@"MSGG:%@", res[@"message"]);
                [ProgressHUD showSuccess:res[@"message"] Interaction:YES];
                
                //go to ConfirmViewController
                [self goConfirmNextVC];
            }
        }else {
            NSLog(@"%@", [res localizedDescription]);
            [ProgressHUD showError:@"Something went wrong. Please try again later!" Interaction:YES];
        }
    }];
}

-(void)goConfirmNextVC {
    [self performSegueWithIdentifier:@"segue_confirmToNext" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"segue_confirmToNext"]) {
        ConfirmNextViewController *vc = [segue destinationViewController];
        vc.phonenumber = phoneNumber;
    }
}


@end
