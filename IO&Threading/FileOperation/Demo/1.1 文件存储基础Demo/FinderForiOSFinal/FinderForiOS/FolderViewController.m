//
//  FolderViewController.m
//  FinderForiOS
//
//  Created by amao on 6/27/16.
//  Copyright © 2016 NetEase. All rights reserved.
//

#import "FolderViewController.h"



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
    
    [self setupUI];
    [self refresh];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UI
- (void)setupUI
{
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:folderCellIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(onAdd:)];
}

- (void)onAdd:(id)sender
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"添加" message:@"选择需要添加的文件类型" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *dirAction = [UIAlertAction actionWithTitle:@"添加目录"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [self createDir];
                                                      }];
    [controller addAction:dirAction];
    
    UIAlertAction *fileAction = [UIAlertAction actionWithTitle:@"添加文本文件"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [self createTextFile];
                                                       }];
    [controller addAction:fileAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancelAction];
    
    [self presentViewController:controller
                       animated:YES
                     completion:nil];
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
    NSString *name = _items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderCellIdentifier];
    cell.textLabel.text = name;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = _items[indexPath.row];
    NSString *path = [self.dir stringByAppendingPathComponent:name];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path
                                             isDirectory:&isDir])
    {
        if (isDir)
        {
            FolderViewController *vc = [[FolderViewController alloc] initWithDir:path];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            NSString *content = [[NSString alloc] initWithContentsOfFile:path
                                                                encoding:NSUTF8StringEncoding
                                                                   error:nil];
            NSLog(@"%@",content);
        }
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *name = _items[indexPath.row];
        [self remove:name];
    }
}


#pragma mark - 目录操作
- (void)refresh
{
    self.items = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_dir
                                                                     error:nil];
    
    [self.tableView reloadData];
}

- (void)createDirByName:(NSString *)name
{
    NSString *path = [self pathByName:name];
    BOOL success =
    [[NSFileManager defaultManager] createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];
    if (success)
    {
        [self refresh];
    }
}

- (void)createTextFileByName:(NSString *)name
{
    NSString *path = [self pathByName:name];
    NSString *content = [NSString stringWithFormat:@"hello world file manager %@",[NSDate date]];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:path
           atomically:YES];
    [self refresh];
    
}

- (NSString *)pathByName:(NSString *)name
{
    NSString *basePath = [self.dir stringByAppendingPathComponent:name];
    NSString *path = basePath;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSInteger index = 0;
    while ([manager fileExistsAtPath:path])
    {
        index++;
        path = [basePath stringByAppendingFormat:@"-%zd",index];
    }
    return path;
}

#pragma mark - 文件操作
- (void)remove:(NSString *)name
{
    if ([name hasPrefix:@"."])
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"警告" message:@"禁止删除隐藏文件" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:controller
                           animated:YES
                         completion:nil];
        return;
    }
    
    NSString *path = [self.dir stringByAppendingPathComponent:name];
    NSError *error = nil;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:path
                                                              error:&error];
    if (error)
    {
        NSLog(@"remove %@ failed error %@",path,error);
    }
    if (success)
    {
        [self refresh];
    }
}

#pragma mark - actions
- (void)createDir
{
    [self createDirByName:@"新建文件目录"];
}

- (void)createTextFile
{
    [self createTextFileByName:@"新文本文件"];
}

@end
