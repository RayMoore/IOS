//
//  FolderViewController.m
//  FinderForiOS
//
//  Created by amao on 6/27/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "FolderViewController.h"

/*
    1.遍历目录
    2.创建目录
    3.删除目录
    4.写入文件
    5.删除文件
    6.读取文件
 
 */



static NSString *folderCellIdentifier = @"folder_cell_identifier";

@interface FolderViewController ()
@property (nonatomic,copy)      NSString        *dir;
@property (nonatomic,copy)      NSArray         *items;
@end

@implementation FolderViewController

- (instancetype)initWithDir:(NSString *)dir
{
    if (self = [super init])
    {
        _dir = [dir copy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI Setup
- (void)setup
{
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:folderCellIdentifier];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderCellIdentifier];
    cell.textLabel.text = name;
    return  cell;
}
@end
