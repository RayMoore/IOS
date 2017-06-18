//
//  CartMainViewController.m
//  BasicUIDesign-project
//
//  Created by Ray on 08/06/2017.
//  Copyright © 2017 com.netease.homework. All rights reserved.
//
#import "CartTableViewCell.h"
#import "CartMainViewController.h"
#import "CartController.h"
#import "CartTableView.h"
#import "CartSectionView.h"
#import "FactorySummaryView.h"
#import "Item.h"
#import "CellPosition.h"


@interface CartMainViewController ()<UITableViewDelegate,UITableViewDataSource>

// total item number for display on nav bar and checkout button
@property (assign,atomic) NSInteger totalItemNum;

// checkout view data-source
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *totalTaxLabel;
@property (assign, atomic) CGFloat checkoutTotalPriceIncludingTax;
@property (assign, atomic) CGFloat checkoutTotalTax;

// table view data-source, sections and rows
@property (strong,atomic) NSMutableArray * sections;
@property (strong,atomic) NSMutableArray * rows;
@property (strong,atomic) NSMutableDictionary *allCells;
@property (strong,atomic) NSMutableDictionary *allFactorySummaryViews;

// controller and data
@property (weak, nonatomic) IBOutlet CartTableView *cartTableView;
@property (strong,atomic) CartController *controller;
@property (strong,atomic) NSMutableDictionary* dataSet;

// for refresh controller
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *refreshLabel;
@property (weak, nonatomic) IBOutlet UILabel *refreshIndicatorLabel;
@property (assign,atomic) BOOL isRefreshing;
@property (strong,atomic) NSTimer *refreshTimer;
@property (assign,atomic) NSInteger countForTime;

// flag for distinction between the first initialization and the later observation of
// changes on check out view
@property (assign,atomic) BOOL afterInit;



@end

@implementation CartMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.controller = [[CartController alloc] init];
    self.dataSet = [self.controller setData];
    self.isRefreshing = NO;
    self.countForTime = 0;
    self.afterInit = NO;
    [self.refreshLabel setHidesWhenStopped:YES];
    [self setSectionsAndRowsWithData:self.dataSet];
    self.totalItemNum = [[self.controller getManager] getTotalItemNumber];
    self.cartTableView.delegate = self;
    self.cartTableView.dataSource = self;
    self.cartTableView.rowHeight = UITableViewAutomaticDimension;
    self.cartTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    self.cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    
    // registerNib for cell reuse
    [self.cartTableView registerNib:[UINib nibWithNibName:@"CartTableViewCell" bundle:nil]  forCellReuseIdentifier:CART_TABLE_VIEW_CELL];
    [self.cartTableView registerNib:[UINib nibWithNibName:@"CartSectionView" bundle:nil] forCellReuseIdentifier:CART_SECTION_VIEW];
    [self.cartTableView registerNib:[UINib nibWithNibName:@"FactorySummaryView" bundle:nil] forCellReuseIdentifier:FACTORY_SUMMARY_VIEW];
    
    // set navigation bar items
    self.navigationItem.title = [@"购物车" stringByAppendingFormat:@"(%ld)",self.totalItemNum];
    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStylePlain target:self action:@selector(getMessage)];
    UIBarButtonItem *barItem2 = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    self.navigationItem.rightBarButtonItems = @[barItem1,barItem2];
    [self.checkoutButton setTitle: [@"结算" stringByAppendingFormat:@"(%ld)",self.totalItemNum]forState:UIControlStateNormal ];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.cartTableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    // initialization is completed, start observing section price change
    self.afterInit = YES;
}


- (void)updateTotalTax:(CGFloat)tax{
    CGFloat originTaxValue = self.checkoutTotalTax;
    CGFloat afterUpdatedTaxValue = originTaxValue + tax;
    CGFloat originTotalPriceValue = self.checkoutTotalPriceIncludingTax;
    CGFloat afterUpdatedTotalPriceValue = originTotalPriceValue + tax;
    NSString *outputString = [NSString stringWithFormat:@"(含税费￥%.2f，不含运费)",afterUpdatedTaxValue];
    [self.totalTaxLabel setText:outputString];
    [self.amountLabel setText:[@"￥" stringByAppendingFormat:@"%.2f",afterUpdatedTotalPriceValue]];
    NSLog(@"税费数据由原始:%.2f 更新到:%.2f",originTaxValue,afterUpdatedTaxValue);
    self.checkoutTotalTax = afterUpdatedTaxValue;
    self.checkoutTotalPriceIncludingTax = afterUpdatedTotalPriceValue;
}

- (void)updateTotalPrice:(CGFloat)price{
    CGFloat originValue = self.checkoutTotalPriceIncludingTax;
    CGFloat afterUpdatedValue = originValue + price;
    NSString *outputString = [NSString stringWithFormat:@"￥%.2f",afterUpdatedValue];
    [self.amountLabel setText:outputString];
    NSLog(@"总价数据由原始:%.2f 更新到:%.2f",originValue,afterUpdatedValue);
    self.checkoutTotalPriceIncludingTax = afterUpdatedValue;
}


- (void)chooseCellWithIndexPath:(NSIndexPath*)indexPath{
    CellPosition *posForFactoryView = [[CellPosition alloc] initWithSection:indexPath.section andRow:0];
    FactorySummaryView *summaryView = (FactorySummaryView*)[self.allFactorySummaryViews objectForKey:posForFactoryView];
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    CartTableViewCell *cell = [self.allCells objectForKey:pos];
    CGFloat tax = [cell getTotalTax];
    CGFloat price = [cell getTotalPrice];
    [summaryView addPrice:price andTax:tax];
    [self updateTotalTax:tax];
    [self updateTotalPrice:price];
}


- (void)cancelCellWithIndexPath:(NSIndexPath*)indexPath{
    CellPosition *posForFactoryView = [[CellPosition alloc] initWithSection:indexPath.section andRow:0];
    FactorySummaryView *summaryView = (FactorySummaryView*)[self.allFactorySummaryViews objectForKey:posForFactoryView];
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    CartTableViewCell *cell = [self.allCells objectForKey:pos];
    CGFloat tax = [cell getTotalTax];
    CGFloat price = [cell getTotalPrice];
    [summaryView substractPrice:price andTax:tax];
    [self updateTotalTax:-tax];
    [self updateTotalPrice:-price];
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


- (void)updateCellByShowingTaxDetailWithCellIndexPath:(NSIndexPath*)indexPath andIfShowTaxDetail:(BOOL)ifShow{
//    [self.cartTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.cartTableView reloadData];

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
    self.checkoutTotalPriceIncludingTax = 0;
    self.checkoutTotalTax = 0;
    self.sections = NULL;
    self.rows = NULL;
    self.allCells = NULL;
    self.allFactorySummaryViews = NULL;
    self.sections = [[NSMutableArray alloc] init];
    self.rows = [[NSMutableArray alloc] init];
    self.allCells = [[NSMutableDictionary alloc] init];
    self.allFactorySummaryViews = [[NSMutableDictionary alloc] init];
    for(NSString *factoryName in dataSet){
        Factory* factory = [dataSet valueForKey:factoryName];
        self.checkoutTotalPriceIncludingTax += [factory getItemTotalPriceIncludingTaxInFactory];
        self.checkoutTotalTax += [factory getItemTotalTaxInFactory];
        [self.sections addObject:factory];
        NSMutableDictionary * items = [factory getItems];
        NSMutableArray *rowArray = [[NSMutableArray alloc] init];
        for(Item* item in items){
            NSMutableDictionary *pair = [[NSMutableDictionary alloc] init];
            [pair setObject:[items objectForKey:item] forKey:item];
            [rowArray addObject:pair];
        }
        [self.rows addObject:rowArray];
    }
    [self.amountLabel setText:[NSString stringWithFormat:@"￥%.2f",self.checkoutTotalPriceIncludingTax]];
    [self.totalTaxLabel setText:[NSString stringWithFormat:@"(含税费￥%.2f，不含运费)",self.checkoutTotalTax]];
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
    

    // customized tableviewcell view height is constantly defined in xib storyboard.
    // do not need to set cell's frame in this function(line below starts with//).
    CartTableViewCell *cell = (CartTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CART_TABLE_VIEW_CELL forIndexPath:indexPath];
    if(cell == nil){
        cell = [self genACartTableViewCell];
    }
    
    
    // get the responding item and setup cell with item info.
    [item_count_pair enumerateKeysAndObjectsUsingBlock:^(Item *key, NSNumber *obj, BOOL *stop) {
        [cell setupWithItem:key andAmount:[obj integerValue] andIndexPath:indexPath andController:self];
        *stop = YES;
    }];
    
    // init a position for storing this cell in allCells NSDictionary.
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    [self.allCells setObject:cell forKey:pos];
    
    return cell;
}


// if queue is empty then call this method to generate a CartTableViewCell
- (CartTableViewCell *)genACartTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:nil options:nil] objectAtIndex:0];
}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}


//set section header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CartSectionView * headerView = (CartSectionView*)[tableView dequeueReusableCellWithIdentifier:CART_SECTION_VIEW];
    if(headerView == nil){
        headerView = [[[NSBundle mainBundle] loadNibNamed:CART_SECTION_VIEW owner:nil options:nil] firstObject];
    }
    NSString * factoryName = [self.sections[section] getFactoryName];
    [headerView setAddressLabelName:factoryName andMainController:self];
    CGRect headerFrame = CGRectMake(0, 0, CGFLOAT_MAX, self.cartTableView.sectionHeaderHeight);
    [headerView setFrame:headerFrame];
    [headerView setSection:section];
    UIView *contentView = [[UIView alloc] initWithFrame:headerFrame];
    [contentView addSubview:headerView];
    return contentView;
}


// set section footer
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    FactorySummaryView *footerView = (FactorySummaryView*)[tableView dequeueReusableCellWithIdentifier:FACTORY_SUMMARY_VIEW];
    if(footerView == nil){
        footerView = [[[NSBundle mainBundle] loadNibNamed:FACTORY_SUMMARY_VIEW owner:nil options:nil] firstObject];
    }
    [footerView setupWithController:self];
    CGRect footerFrame = CGRectMake(0, 0, CGFLOAT_MAX, self.cartTableView.sectionFooterHeight);
    [footerView setFrame:footerFrame];
    [footerView setSummaryViewPrice:[self.sections[section] getItemTotalPriceInFactory] andTax:[self.sections[section] getItemTotalTaxInFactory]];
    CellPosition *pos = [[CellPosition alloc] initWithSection:section andRow:0];
    [self.allFactorySummaryViews setObject:footerView forKey:pos];
    UIView *contentView = [[UIView alloc] initWithFrame:footerFrame];
    [contentView addSubview:footerView];
    return contentView;
}

#pragma mark -table view delegate

// table view delegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    CartTableViewCell * cell = [self.allCells objectForKey:pos];
    if(cell != nil && [cell getShowTaxStatus]==SHOW_TAX){
        return 170;
    }else{
        return 120;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    CartTableViewCell * cell = [self.allCells objectForKey:pos];
    if(cell != nil && [cell getShowTaxStatus]==SHOW_TAX){
        return 170;
    }else{
        return 120;
    }
}


// ignore the observer when the cell is out of screen
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CellPosition *pos = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
    CartTableViewCell *thisCell = [self.allCells objectForKey:pos];
    [thisCell ignoreImageObserver];
}

//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
//    CellPosition *pos = [[CellPosition alloc] initWithSection:section andRow:0];
//    FactorySummaryView *thisView = [self.allFactorySummaryViews objectForKey:pos];
//    [thisView ignoreCheckoutObserver];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // cancel default style
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    return UITableViewCellEditingStyleDelete;
}


// delete cell
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSString* factoryName = [self.sections[indexPath.section] getFactoryName];
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
            
            CellPosition *posForCell = [[CellPosition alloc] initWithSection:indexPath.section andRow:indexPath.row];
            CartTableViewCell *cell = [self.allCells objectForKey:posForCell];
            BOOL chooseStatus = [cell getChooseStatus];
            if(chooseStatus == CHOOSE){
                [self cancelCellWithIndexPath:indexPath];
                [(Factory*)[self.sections objectAtIndex:indexPath.section] removeItem:item];
            }
            [rowArray removeObjectAtIndex:indexPath.row];
            [self.allCells removeObjectForKey:posForCell];
            
            
            if([rowArray count] == 0){
                [self.sections removeObjectAtIndex:indexPath.section];
                [self.rows removeObjectAtIndex:indexPath.section];
                CellPosition *posForSummaryView = [[CellPosition alloc] initWithSection:indexPath.section andRow:0];
                [self.allFactorySummaryViews removeObjectForKey:posForSummaryView];
            }
            
            
            [self.cartTableView reloadData];
        }];
        [alert addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


// show activity indictor label when offset < -40
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
