//
//  CSConnectListViewController.m
//  CSChatKitDemo
//
//  Created by wangchengshan on 16/7/6.
//  Copyright © 2016年 WCS. All rights reserved.
//

#import "CSConnectListViewController.h"
#import "CSChatViewController.h"

@interface CSConnectListViewController ()

@end

@implementation CSConnectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"connectList"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"connectList"];
    }
    cell.textLabel.text = @"哈哈哈哈";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CSChatViewController *chatVC = [[CSChatViewController alloc]init];
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

@end
