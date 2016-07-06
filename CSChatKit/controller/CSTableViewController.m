//
//  CSTableViewController.m
//  CSChatKitDemo
//
//  Created by wangchengshan on 16/7/6.
//  Copyright © 2016年 WCS. All rights reserved.
//

#import "CSTableViewController.h"
#import <Masonry.h>

@interface CSTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建子控件
    [self setupRootSubView];
    //布局子控件
    [self layoutRootSubView];
}

- (void)setupRootSubView
{
    //背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:CSChatSrcName(@"ChatBackgroundThumb.jpg")]];
    bgImageView.backgroundColor = [UIColor clearColor];
    bgImageView.userInteractionEnabled = YES;
    [bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBoard)]];
    [self.view addSubview:bgImageView];
    self.bgImageView = bgImageView;
    //表格
    UITableView *tableView = [[UITableView alloc]init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)layoutRootSubView
{
    //背景
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //表格
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hiddenKeyBoard];
}

- (void)hiddenKeyBoard
{
    [self.view endEditing:YES];
}
@end
