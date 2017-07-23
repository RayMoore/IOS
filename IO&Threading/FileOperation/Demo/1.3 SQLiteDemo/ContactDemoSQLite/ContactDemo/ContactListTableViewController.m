//
//  ContactListTableViewController.m
//  ContactDemo
//
//  Created by amao on 16/7/18.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ContactListTableViewController.h"
#import "AddContactViewController.h"
#import <sqlite3.h>


static NSString *contactReuseIdentifier = @"contact_reuse_identifier";


@interface ContactListTableViewController ()<AddContactDelegate,UISearchBarDelegate,UISearchResultsUpdating>
@property (nonatomic,strong)    UISearchController *searchViewController;
@property (nonatomic,copy)      NSMutableArray *contacts;
@property (nonatomic,copy)      NSArray *filteredContacts;
@property (nonatomic,assign)    BOOL shouldShowSearchResult;
@property (nonatomic,assign)    sqlite3 *db;
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
    sqlite3_close(_db);
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
        NSString *sql = @"delete from contacts where id = ?";
        sqlite3_stmt *stmt = NULL;
        
        if (sqlite3_prepare(_db, [sql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
        {
            sqlite3_bind_int64(stmt, 1, serialId);
            
            if (sqlite3_step(stmt) == SQLITE_DONE)
            {
                [self.contacts removeObjectAtIndex:index];
                [self.tableView reloadData];
            }
            
            sqlite3_finalize(stmt);
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
    if (sqlite3_open([filepath UTF8String], &_db) == SQLITE_OK)
    {
        NSString *sql = @"create table if not exists contacts(id integer primary key autoincrement,name text,mobile text)";
        if(sqlite3_exec(_db, [sql UTF8String], NULL, NULL, NULL) != SQLITE_OK)
        {
            NSLog(@"create table failed");
        }
    }
    else
    {
        NSLog(@"open database failed");
    }
}

- (void)read
{
    sqlite3_stmt *stmt = NULL;
    NSString *sql = @"select * from contacts";
    if(sqlite3_prepare(_db,[sql UTF8String],-1, &stmt, NULL) == SQLITE_OK)
    {
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int64_t serialId = sqlite3_column_int64(stmt, 0);
            const char *name = (const char *)sqlite3_column_text(stmt, 1);
            const char *mobile = (const char *)sqlite3_column_text(stmt, 2);
            
            if (name && mobile)
            {
                Contact *contact =[[Contact alloc] init];
                contact.serialId = serialId;
                contact.name = [NSString stringWithUTF8String:name];
                contact.mobile = [NSString stringWithUTF8String:mobile];
                [self.contacts addObject:contact];
            }
        }
        sqlite3_finalize(stmt);
    }
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
    sqlite3_stmt *stmt = NULL;
    NSString *sql = @"insert into contacts (name,mobile) values (?,?)";
    if(sqlite3_prepare(_db,[sql UTF8String], -1, &stmt, NULL) == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [contact.name UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [contact.mobile UTF8String], -1 , NULL);
        
        int result = sqlite3_step(stmt);
        if (result == SQLITE_DONE)
        {
            contact.serialId = sqlite3_last_insert_rowid(_db);
            
            [self.contacts addObject:contact];
            [self.tableView reloadData];
        }
        sqlite3_finalize(stmt);
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
        sqlite3_stmt *stmt = NULL;
        NSString *sql = @"select * from contacts where name like ? or mobile like ?";
        if(sqlite3_prepare(_db,[sql UTF8String], -1 , &stmt, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(stmt, 1, [searchText UTF8String], -1, NULL);
            sqlite3_bind_text(stmt, 2, [searchText UTF8String], -1, NULL);
            
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                int64_t serialId = sqlite3_column_int64(stmt, 0);
                const char *name = (const char *)sqlite3_column_text(stmt, 1);
                const char *mobile = (const char *)sqlite3_column_text(stmt, 2);
                
                if (name && mobile)
                {
                    Contact *contact =[[Contact alloc] init];
                    contact.serialId = serialId;
                    contact.name = [NSString stringWithUTF8String:name];
                    contact.mobile = [NSString stringWithUTF8String:mobile];
                    [contacts addObject:contact];
                }
            }
            sqlite3_finalize(stmt);
        }
    }

    self.filteredContacts = contacts;
    [self.tableView reloadData];
}



@end
