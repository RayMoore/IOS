//
//  TableViewController.m
//  TableView
//
//  Created by wtndcs on 16/8/27.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "MessageInfo.h"
#import "CustomTableViewCell.h"
#import "NormalTableViewCell.h"

static NSString * CUSTOM_REUSE_ID = @"CustomTableViewCell";

static NSString * NORMAL_REUSE_ID = @"NormalTableViewCell";

@interface TableViewController ()

@property (nonatomic, strong) NSArray *sections;

@property (nonatomic, strong) NSArray *rows;

@property (nonatomic, assign) NSInteger calculateCount;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MessageInfo *msgInfo = [[MessageInfo alloc] init];
    msgInfo.title = @"我的资产";
    msgInfo.detail = @"你有6张优惠券今日过期，不要浪费。可以去看看有没有合适的~";
    msgInfo.hintNum = 5;
    msgInfo.timeStr = @"09:22";
    
    self.sections = @[ @"Section A", @"Section B", @"Section C", @"Section D" ];
    
    self.rows = @[ @[ msgInfo, @"Row 1", @"Row 2" ],
                   @[ @"Row 0\nRow2\nRow3\nRow4", @"Row 1" ],
                   @[ @"Row 0", @"Row 1", @"Row 2", @"Row 3" ],
                   @[ @"Row 0", @"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", @"Row 6", @"Row 7",@"Row 8", @"Row 9", @"Row 10", @"Row 11", @"Row 12", @"Row 13", @"Row 14", @"Row 15", @"Row 16", @"Row 17",@"Row 18", @"Row 19",@"Row 0", @"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", @"Row 6", @"Row 7",@"Row 8", @"Row 9", @"Row 10", @"Row 11", @"Row 12", @"Row 13", @"Row 14", @"Row 15", @"Row 16", @"Row 17",@"Row 18", @"Row 19"  ],
                  ];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:CUSTOM_REUSE_ID];
    
    [self.tableView registerClass:[NormalTableViewCell class] forCellReuseIdentifier:NORMAL_REUSE_ID];
    self.tableView.allowsMultipleSelection = YES;
//    self.tableView.editing = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowArray = self.rows[section];
    return rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rowArray = self.rows[indexPath.section];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        MessageInfo *msgInfo = rowArray[indexPath.row];
        CustomTableViewCell *customCell = [self.tableView dequeueReusableCellWithIdentifier:CUSTOM_REUSE_ID forIndexPath:indexPath];
        [customCell setupMsgInfo:msgInfo];
        return customCell;
    }
    else {
        NSString *title = rowArray[indexPath.row];
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NORMAL_REUSE_ID forIndexPath:indexPath];
        cell.textLabel.text = title;
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"Detail Info";
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.imageView.image = [UIImage imageNamed:@"mc_broadcast"];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.frame = CGRectMake(0, 0, 200, 40);
        cell.detailTextLabel.frame = CGRectMake(80, 0, 50, 40);
        
        return cell;
    }
}

- (CustomTableViewCell *)genCustomCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil];
    return  [topLevelObjects objectAtIndex:0];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = self.sections[section];
    sectionTitle = [sectionTitle stringByAppendingString:@" Header"];
    return sectionTitle;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除" message:@"你确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MessageInfo *msgInfo = [[MessageInfo alloc] init];
            msgInfo.title = @"我的资产";
            msgInfo.detail = @"你有6张优惠券今日过期，不要浪费。可以去看看有没有合适的~";
            msgInfo.hintNum = 5;
            msgInfo.timeStr = @"09:22";
            
            //[self.tableView beginUpdates];
            self.rows = @[ @[ msgInfo, @"Row 1" ],
                           @[ @"Row 0\nRow2\nRow3\nRow4", @"Row 1", @"Row 2" ],
                           @[ @"Row 0", @"Row 1", @"Row 2" ],
                           @[ @"Row 0", @"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", @"Row 6", @"Row 7",@"Row 8", @"Row 9", @"Row 10", @"Row 11", @"Row 12", @"Row 13", @"Row 14", @"Row 15", @"Row 16", @"Row 17",@"Row 18", @"Row 19",@"Row 0", @"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", @"Row 6", @"Row 7",@"Row 8", @"Row 9", @"Row 10", @"Row 11", @"Row 12", @"Row 13", @"Row 14", @"Row 15", @"Row 16", @"Row 17",@"Row 18", @"Row 19"  ],
                           ];
            
            
            [self.tableView reloadData];
        }];
        [alert addAction:confirmAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
//        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0], [NSIndexPath indexPathForRow:3 inSection:2]] withRowAnimation:UITableViewRowAnimationAutomatic];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
        //[self.tableView endUpdates];
        NSLog(@"Delete");
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        NSMutableArray *sections = [self.rows mutableCopy];
        NSMutableArray *rows = [sections[indexPath.section] mutableCopy];
        NSString *value = [rows[indexPath.row] stringByAppendingString:@" Copy"];
        [rows addObject:value];
        sections[indexPath.section] = rows;
        self.rows = sections;
        
        NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:rows.count - 1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        NSLog(@"Insert");
    }
}

# pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleDelete;
    }
    else if (indexPath.section == 1) {
        return UITableViewCellEditingStyleInsert;
    }
    else if (indexPath.section == 2) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // NSLog(@"Move Row");
    // self.tableView moveRowAtIndexPath:<#(nonnull NSIndexPath *)#> toIndexPath:<#(nonnull NSIndexPath *)#>
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    self.calculateCount ++;
//    NSLog(@"Calculate heightForRowAtIndexPath %@", @(self.calculateCount));
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        NSArray *rowArray = self.rows[indexPath.section];
//        MessageInfo *msgInfo = rowArray[indexPath.row];
//        CustomTableViewCell *customCell = [self genCustomCell];
//        [customCell setupMsgInfo:msgInfo];
//        
//        CGSize size = [customCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        return size.height;
//    }
//    return 50;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (void)dealloc
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

@end
