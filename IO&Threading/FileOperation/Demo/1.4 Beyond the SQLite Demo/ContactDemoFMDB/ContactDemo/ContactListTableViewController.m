//
//  ContactListTableViewController.m
//  ContactDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ContactListTableViewController.h"
#import "AddContactViewController.h"
#import "FMDatabase.h"


static NSString *contactReuseIdentifier = @"contact_reuse_identifier";


@interface ContactListTableViewController ()<AddContactDelegate,UISearchBarDelegate,UISearchResultsUpdating>
@property (nonatomic,strong)    UISearchController *searchViewController;
@property (nonatomic,copy)      NSMutableArray *contacts;
@property (nonatomic,copy)      NSArray *filteredContacts;
@property (nonatomic,assign)    BOOL shouldShowSearchResult;
@property (nonatomic,strong)    FMDatabase *database;
@end

@implementation ContactListTableViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _contacts = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    [_database close];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self openDatabase];
    [self read];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shouldShowSearchResult ? [self.filteredContacts count] : [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    Contact *contact = self.shouldShowSearchResult ? self.filteredContacts[index] : self.contacts[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:contactReuseIdentifier];
    }
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.mobile;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.shouldShowSearchResult == NO;   //搜索结果不做删除处理
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSInteger index = [indexPath row];
        int64_t serialId = [self.contacts[index] serialId];
        
        if ([_database executeUpdate:@"delete from contacts where id = ?",@(serialId)])
        {
            [self.contacts removeObjectAtIndex:index];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - misc
- (void)setup
{
    self.title = @"联系人列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(add:)];
    

    self.searchViewController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchViewController.searchBar.delegate = self;
    self.searchViewController.searchResultsUpdater = self;
    self.tableView.tableHeaderView = self.searchViewController.searchBar;
    
}

- (void)add:(id)sender
{
    AddContactViewController *vc = [[AddContactViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - store
- (void)openDatabase
{
    NSString *filepath = [self filepath];
    _database = [FMDatabase databaseWithPath:filepath];
    if ([_database open])
    {
        if (![_database executeUpdate:@"create table if not exists contacts(id integer primary key autoincrement,name text,mobile text)"])
        {
            NSLog(@"open database failed");
        }
    }
    else
    {
        NSLog(@"open database failed");
    }
}

- (void)read
{
    FMResultSet *set = [_database executeQuery:@"select * from contacts"];
    while ([set next])
    {
        Contact *contact =[[Contact alloc] init];
        contact.serialId = [set longLongIntForColumn:@"id"];
        contact.name = [set stringForColumn:@"name"];
        contact.mobile = [set stringForColumn:@"mobile"];
        [self.contacts addObject:contact];
    }
    [set close];
    [self.tableView reloadData];
}



- (NSString *)filepath
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return  [documents stringByAppendingPathComponent:@"contacts.db"];
}

#pragma mark - AddContactDelegate
- (void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddContact:(Contact *)contact
{

    if ([_database executeUpdate:@"insert into contacts (name,mobile) values (?,?)",contact.name,contact.mobile])
    {
        [self.contacts addObject:contact];
        [self.tableView reloadData];

    }
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - search
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = YES;
    self.filteredContacts = nil;
    [self.tableView reloadData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredContacts = nil;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.shouldShowSearchResult = NO;
    self.filteredContacts = nil;
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *text = searchController.searchBar.text;
    NSMutableArray *contacts = nil;
    if ([text length])
    {
        NSString *searchText = [NSString stringWithFormat:@"%%%@%%",text];
        contacts = [NSMutableArray array];
        NSString *sql = @"select * from contacts where name like ? or mobile like ?";
        
        FMResultSet *set = [_database executeQuery:sql,searchText,searchText];
        while ([set next])
        {
            Contact *contact =[[Contact alloc] init];
            contact.serialId = [set longLongIntForColumn:@"id"];
            contact.name = [set stringForColumn:@"name"];
            contact.mobile = [set stringForColumn:@"mobile"];
            [contacts addObject:contact];
        }
        [set close];
    }

    self.filteredContacts = contacts;
    [self.tableView reloadData];
}
@end
