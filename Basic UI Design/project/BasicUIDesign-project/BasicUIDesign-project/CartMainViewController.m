//
//  CartMainViewController.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//

#import "CartMainViewController.h"
#import "CartController.h"
#import "CartTableViewCell.h"
#import "CartTableView.h"
#import "CartSectionView.h"
#import "FactorySummaryView.h"
#import "Item.h"
#import "CellPosition.h"

@interface CartMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (assign,atomic) NSInteger totalItemNum;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *totalTaxLabel;
@property (strong,atomic) NSMutableArray * sections;
@property (strong,atomic) NSMutableArray * rows;
@property (weak, nonatomic) IBOutlet CartTableView *cartTableView;
@property (strong,atomic) CartController *controller;
@property (strong,atomic) NSMutableDictionary* dataSet;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *refreshLabel;
@property (weak, nonatomic) IBOutlet UILabel *refreshIndicatorLabel;
@property (assign,atomic) BOOL isRefreshing;
@property (strong,atomic) NSTimer *refreshTimer;
@property (assign,atomic) NSInteger countForTime;
@property (strong,atomic) NSMutableDictionary *allCells;

@end

@implementation CartMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.controller = [[CartController alloc] init];
    self.dataSet = [self.controller setData];
    self.isRefreshing = NO;
    self.countForTime = 0;
    [self.refreshLabel setHidesWhenStopped:YES];
    [self setSectionsAndRowsWithData:self.dataSet];
    self.totalItemNum = [[self.controller getManager] getTotalItemNumber];
    self.cartTableView.delegate = self;
    self.cartTableView.dataSource = self;
    self.cartTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [self.cartTableView registerNib:[UINib nibWithNibName:@"CartTableViewCell" bundle:nil]  forCellReuseIdentifier:CART_TABLE_VIEW_CELL];
    [self.cartTableView registerNib:[UINib nibWithNibName:@"CartSectionView" bundle:nil] forCellReuseIdentifier:CART_SECTION_VIEW];
    [self.cartTableView registerNib:[UINib nibWithNibName:@"FactorySummaryView" bundle:nil] forCellReuseIdentifier:FACTORY_SUMMARY_VIEW];
    
    
    //    CartTableView* cartTableView = [[CartTableView alloc] initWithData:dataSet];
    self.navigationItem.title = [@"购物车" stringByAppendingFormat:@"(%ld)",self.totalItemNum];
    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(getMessage)];
    UIBarButtonItem *barItem2 = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItems = @[barItem1,barItem2];
    [self.checkoutButton setTitle: [@"结算" stringByAppendingFormat:@"(%ld)",self.totalItemNum]forState:UIControlStateNormal ];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.cartTableView reloadData];
}

- (void)sectionAllChoose:(NSInteger)section andSelection:(BOOL)ifChoose{
    NSMutableArray *rowArray = self.rows[section];
    NSInteger count = [rowArray count];
    for(NSInteger i=0; i<count; i++){
        CellPosition *pos = [[CellPosition alloc] initWithSection:section andRow:i];
        CartTableViewCell *cell = [self.allCells objectForKey:pos];
        [cell makeAllChooseBySelection:ifChoose];
    }

}

- (void)showMessageWithTitle:(NSString*)title andMessage:(NSString*)msg{
    
    UIAlertController *messageAlertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    
    [messageAlertController addAction:cancelAction];
    [messageAlertController addAction:okAction];
    [self presentViewController:messageAlertController animated:YES completion:nil];
}

- (void)setSectionsAndRowsWithData:(NSMutableDictionary*)dataSet{
    self.sections = [[NSMutableArray alloc] init];
    self.rows = [[NSMutableArray alloc] init];
    self.allCells = [[NSMutableDictionary alloc] init];
    for(NSString *factoryName in dataSet){
        Factory* factory = [dataSet valueForKey:factoryName];
        [self.sections addObject:[factory getFactoryName]];
        NSMutableDictionary * items = [factory getItems];
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for(Item* item in items){
            NSMutableDictionary *pair = [[NSMutableDictionary alloc] init];
            [pair setObject:[items objectForKey:item] forKey:item];
            [rowArray addObject:pair];
        }
        [self.rows addObject:rowArray];
    }

    
}


- (void)addInset{
    UIEdgeInsets inset = self.cartTableView.contentInset;
    inset.top += 70;
    self.cartTableView.contentInset = inset;
}

- (void)removeInset{
    UIEdgeInsets inset = self.cartTableView.contentInset;
    inset.top -= 70;
    self.cartTableView.contentInset = inset;
}

- (void)refreshData{
    self.countForTime+=1;
    if(self.countForTime>5){
        self.countForTime=0;
        self.dataSet = [self.controller setData];
        [self setSectionsAndRowsWithData:self.dataSet];
        [self removeInset];
        [self.cartTableView reloadData];
        self.isRefreshing = NO;
        [self.refreshLabel stopAnimating];
        [self.refreshLabel setHidden:YES];
        [self.refreshIndicatorLabel setHidden:YES];
        [self.refreshTimer invalidate];
        NSLog(@"停止刷新");
        [self.cartTableView setUserInteractionEnabled:YES];
        return;
    }
    [self.refreshLabel startAnimating];
    
}

- (void)edit{
    [self showMessageWithTitle:@"编辑" andMessage:@"正在编辑..."];
}

- (void)getMessage{
    [self showMessageWithTitle:@"消息中心" andMessage:@"正在接受消息..."];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rows[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rowArray = self.rows[indexPath.section];
    NSMutableDictionary *item_count_pair = rowArray[indexPath.row];
    
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CART_TABLE_VIEW_CELL forIndexPath:indexPath];
    [cell setFrame:CGRectMake(0, 0, self.cartTableView.frame.size.width, CGFLOAT_MAX)];
    [item_count_pair enumerateKeysAndObjectsUsingBlock:^(Item *key, NSNumber *obj, BOOL *stop) {
        [cell setupWithItem:key andAmount:[obj integerValue]];
        *stop = YES;
    }];
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    [self.allCells setObject:cell forKey:pos];
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
//    return 130;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    return 40;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CartSectionView * headerView = [tableView dequeueReusableCellWithIdentifier:CART_SECTION_VIEW];
    NSString * factoryName = self.sections[section];
    [headerView setAddressLabelName:factoryName andMainController:self];
    CGRect headerFrame = CGRectMake(0, 0, CGFLOAT_MAX, self.cartTableView.sectionHeaderHeight);
    [headerView setFrame:headerFrame];
    [headerView setSection:section];
    UIView *contentView = [[UIView alloc] initWithFrame:headerFrame];
    [contentView addSubview:headerView];
    return contentView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FactorySummaryView *footerView = [[[NSBundle mainBundle] loadNibNamed:FACTORY_SUMMARY_VIEW owner:nil options:nil] firstObject];
    CGRect footerFrame = CGRectMake(0, 0, CGFLOAT_MAX, self.cartTableView.sectionFooterHeight);
    [footerView setFrame:footerFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:footerFrame];
    [contentView addSubview:footerView];
    return contentView;
}

// table view delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// cancel default style
    // other actions
    NSArray *rowArray = self.rows[indexPath.section];
    NSDictionary *pair = rowArray[indexPath.row];
    [pair enumerateKeysAndObjectsUsingBlock:^(Item* key, NSNumber* obj, BOOL *stop){
        NSString* itemName = key.itemDescription;
        [self showMessageWithTitle:@"跳转商品页面" andMessage:[@"跳转至选中商品：\n" stringByAppendingFormat:@"%@", itemName]];
        *stop = YES;
    }];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *rowArray = self.rows[indexPath.section];
    if(indexPath.row>=0&&indexPath.row<[rowArray count]){
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSString* factoryName = self.sections[indexPath.section];
        NSMutableArray *rowArray = self.rows[indexPath.section];
        NSDictionary *pair = rowArray[indexPath.row];
        __block Item * item;
        [pair enumerateKeysAndObjectsUsingBlock:^(Item* key,NSNumber* obj,BOOL* stop){
            item = key;
            *stop = YES;
        }];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除商品" message:@"你确定要删除这件商品吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.controller removeItem: item fromFactory:factoryName];
            self.dataSet = [self.controller getData];
            [self setSectionsAndRowsWithData:self.dataSet];
            [self.cartTableView reloadData];
        }];
        [alert addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.cartTableView.contentOffset.y<-40){
        [self.refreshLabel setHidden:NO];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.cartTableView.contentOffset.y<-70&&!self.isRefreshing){
        self.isRefreshing = YES;
        [self.refreshIndicatorLabel setHidden:NO];
        NSLog(@"开始刷新");
        [self.cartTableView setUserInteractionEnabled:NO];
        [self addInset];
        self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshData) userInfo:nil repeats:YES];
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
