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

@interface TableViewController ()

@property (nonatomic, strong) NSArray *sections;

@property (nonatomic, strong) NSArray *rows;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MessageInfo *msgInfo = [[MessageInfo alloc] init];
    msgInfo.title = @"我的资产";
    msgInfo.detail = @"你有6张优惠券今日过期，不要浪费。可以去看看";
    msgInfo.hintNum = 5;
    msgInfo.timeStr = @"09:22";
    
    self.sections = @[ @"Section A" ];
    
    self.rows = @[ @[ msgInfo, @"Row 1", @"Row 2" ],
                   @[ @"Row 0", @"Row 1" ],
                   @[  ],
                   @[ @"Row 0", @"Row 1", @"Row 2", @"Row 3" ],
                  ];
    
    self.tableView.separatorColor = [UIColor redColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    header.backgroundColor = [UIColor greenColor];
    self.tableView.tableHeaderView = header;
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
        CustomTableViewCell *customCell = [self genCustomCell];
        [customCell setupMsgInfo:msgInfo];
       // customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return customCell;
    }
    else {
        NSString *title = rowArray[indexPath.row];
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.text = title;
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"Detail Info";
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.imageView.image = [UIImage imageNamed:@"mc_broadcast"];
        
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor greenColor];
        
        cell.textLabel.frame = CGRectMake(0, 0, 200, 40);
        cell.detailTextLabel.frame = CGRectMake(80, 0, 50, 40);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
        
        return cell;
    }
}

- (CustomTableViewCell *)genCustomCell
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil];
    return  [topLevelObjects objectAtIndex:0];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = self.sections[section];
    sectionTitle = [sectionTitle stringByAppendingString:@" Header"];
    return sectionTitle;
}

//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    NSString *sectionTitle = self.sections[section];
//    sectionTitle = [sectionTitle stringByAppendingString:@" Footer"];
//    return sectionTitle;
//}

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return self.sections;
//}

# pragma mark - Table view delegate

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSArray *rowArray = self.rows[indexPath.section];
        MessageInfo *msgInfo = rowArray[indexPath.row];
        CustomTableViewCell *customCell = [self genCustomCell];
        [customCell setupMsgInfo:msgInfo];
        
        CGSize size = [customCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height;
        
//        NSString *detailStr = msgInfo.detail;
//        CGSize size = CGSizeMake(tableView.frame.size.width - 38 - 54, CGFLOAT_MAX);
//        CGRect rect = [detailStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:13] } context:nil];
//        CGFloat height = rect.size.height + 41;
//        
//        return height;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 20;
//}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    headerView.backgroundColor = [UIColor redColor];
//    return headerView;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
//    footerView.backgroundColor = [UIColor greenColor];
//    return footerView;
//}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return NO;
    }
    return YES;
}

//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"Did Highlight");
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    ViewController *vc = [[ViewController alloc] init];
////    [self.navigationController pushViewController:vc animated:YES];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
