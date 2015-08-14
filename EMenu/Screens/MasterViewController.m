//
//  MasterViewController.m
//  dd
//
//  Created by Chen, Jonny on 11/21/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Dish_category.h"
#import "AppConstants.h"
#import "DishDAO.h"

@implementation MasterViewController
@synthesize appCallback;
@synthesize restaurant;
							
- (void)dealloc
{
    [_detailViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    
    self.navigationController.navigationBar.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    
    UIBarButtonItem *backBtn =[[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"homeHD.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(onHomeClicked:)]autorelease];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    categoryList =[[UITableView alloc] initWithFrame:CGRectMake(2, 5, self.view.frame.size.width-4, self.view.frame.size.height -50) style:UITableViewStylePlain];
    categoryList.backgroundColor =[UIColor clearColor];
    categoryList.dataSource =self;
    categoryList.delegate =self;
    [self.view addSubview:categoryList];
}
-(void)onHomeClicked:(id)sender
{
    if(appCallback!=nil){
        [appCallback loadRestaurantList];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.restaurant.dish_categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    Dish_category * cat = [restaurant.dish_categories objectAtIndex:indexPath.row];
    cell.textLabel.text = cat.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dish_category * selectedCategory =[self.restaurant.dish_categories objectAtIndex:indexPath.row];
    NSDictionary * _restaurantAndCategory =[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.restaurant.ID] , @"restaurant_id", [NSString stringWithFormat:@"%d",selectedCategory.ID] ,@"category_id",@"1",@"dish_pictures",nil];
    self.detailViewController.restaurantAndCategory = _restaurantAndCategory;
}

@end
