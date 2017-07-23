//
//  ContactListTableViewController.m
//  PropertyListDemo
//
//  Created by amao on 16/7/13.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import "ContactListTableViewController.h"
#import "AddContactViewController.h"


static NSString *contactReuseIdentifier = @"contact_reuse_identifier";


@interface ContactListTableViewController ()<AddContactDelegate>
@property (nonatomic,strong)    NSMutableArray *contacts;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
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
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    NSDictionary *contact = self.contacts[index];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contactReuseIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:contactReuseIdentifier];
    }
    cell.textLabel.text = contact[@"name"];
    cell.detailTextLabel.text = contact[@"mobile"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSInteger index= [indexPath row];
        [self.contacts removeObjectAtIndex:index];
        [self.tableView reloadData];
        [self save];
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
}

- (void)add:(id)sender
{
    AddContactViewController *vc = [[AddContactViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - AddContactDelegate
- (void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onAddContact:(NSDictionary *)dict
{
    [self.contacts addObject:dict];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
    
    [self save];
}

#pragma mark - store
- (NSString *)filepath
{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documents stringByAppendingPathComponent:@"contacts.plist"];
}

- (void)save
{
    [_contacts writeToFile:[self filepath]
                atomically:YES];
}

- (void)read
{
    NSArray *contacts = [NSArray arrayWithContentsOfFile:[self filepath]];
    if (contacts)
    {
        self.contacts = [NSMutableArray arrayWithArray:contacts];
    }
}
@end
