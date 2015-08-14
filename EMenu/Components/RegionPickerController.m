//
//  RegionPickerController.m
//  EMenu
//
//  Created by Chen, Jonny on 11/28/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "RegionPickerController.h"

@interface RegionPickerController ()

@end

@implementation RegionPickerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(150.0, 140.0);
    self.regions = [NSMutableArray array];
    [self.regions addObject:@"黄浦区"];
    [self.regions addObject:@"卢湾区"];
    [self.regions addObject:@"浦东新区"];
    [self.regions addObject:@"普陀区"];
    [self.regions addObject:@"长宁区"];
    
}
-(void)dealloc
{
    self.regions =nil;
    self.delegate =nil;
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.regions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [self.regions objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment=UITextAlignmentLeft;
    cell.textLabel.textColor =[UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.backgroundColor =[UIColor clearColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
