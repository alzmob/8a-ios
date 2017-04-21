//
//  ProfileViewController.m
//  8a-ios
//
//  Created by Alex Zhang on 21/04/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ProfileViewController.h"
#import "MyLabelCell.h"
#import "MyTextViewCell.h"
#import "MyImageCell.h"
#import "UIImageView+WebCache.h"

@interface ProfileViewController (){
    NSMutableArray *myData;
}

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myData = [[NSMutableArray alloc] init];
    
    [self getProfileDataFromAPI];
}

- (void)getProfileDataFromAPI {
    NSString *auth = [NSString stringWithFormat:@"Bearer {%@}", self.token];
    [[APIManager shared] getProfile:auth withCompletion:^(BOOL success, id res) {
        if (success) {
            NSLog(@"profile_data: %@", res);
            NSArray *ary = (NSArray *)[res objectForKey:@"data"];
            [myData addObjectsFromArray:ary];
            [self.tableview reloadData];
        }else {
            [ProgressHUD showError:@"Failed data!"];
        }
    }];
}

- (IBAction)logoutButtonClicked:(id)sender {
    //TODO: logout action
    
    //go firstViewController
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"labelCell";
    
    NSString * type = [myData[indexPath.row] objectForKey:@"field_type"];
    NSString * title = [myData[indexPath.row] objectForKey:@"label"];
    NSString * value = [myData[indexPath.row] objectForKey:@"value"];
    
    if ([type isEqualToString:@"image"]) {
        identifier = @"imageCell";
        MyImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        cell.titleLbl.text = title;
        [cell.imgview sd_setImageWithURL:[[NSURL alloc] initWithString:value]];
        
        return cell;
        
    } else if ([type isEqualToString:@"textarea"]) {
        identifier = @"textCell";
        MyTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        cell.titleLbl.text = title;
        cell.textview.text = value;
        
        return cell;
        
    } else {
        MyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        cell.titleLbl.text = title;
        cell.dataLbl.text = value;
        
        return cell;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
