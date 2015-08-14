//
//  ChooseRestaurantCtrl.m
//  EMenu
//
//  Created by Chen, Jonny on 11/22/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "ChooseRestaurantCtrl.h"
#import <QuartzCore/QuartzCore.h>
#import "GradientButton.h"
#import "RestaurantShowCtrl.h"
#import "Restaurant.h"

@interface ChooseRestaurantCtrl ()
{
    NSArray * restaurants;
    UIImageView* backgroundImageView;
    UITableView * tableView;
}
@end

@implementation ChooseRestaurantCtrl
@synthesize panel;
@synthesize appCallback;


- (void)viewWillLayoutSubviews{
    backgroundImageView.frame = self.view.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    panel =[[UIView alloc]init];
    panel.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg3.png"]];
    [panel.layer setCornerRadius:14];
    [panel.layer setBorderColor:[[UIColor grayColor] CGColor]];
    
    backgroundImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    backgroundImageView.frame = self.view.frame;
    [self.view addSubview:backgroundImageView];
    
    panel.frame =CGRectMake(162, 150, 600, 468);
    panel.alpha = 0;
    [self.view addSubview:panel];
    
    GradientButton * skipBtn = [[GradientButton alloc] initWithFrame:CGRectMake(470, 405, 100, 32)];
    [skipBtn useAlertStyle];
    [skipBtn setTitle: NSLocalizedString(@"跳过", nil) forState:UIControlStateNormal];
    [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    skipBtn.tag =1;
    [skipBtn addTarget:self action:@selector(onSkipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [panel addSubview:skipBtn];
    [skipBtn release];
    
    UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(100, 30, 400, 32)];
    label.text =@"附近的餐厅";
    label.font =[UIFont fontWithName:@"Helvetica" size:20];
    label.textColor =[UIColor whiteColor];
    label.backgroundColor =[UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    [panel addSubview:label];
    [label release];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 80, 500, 320) style:UITableViewStylePlain];
    tableView.backgroundColor =[UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorColor =[UIColor lightGrayColor];
    [panel addSubview:tableView];
    [panel release];
    [self loadData];
}
-(void)loadData
{
    [[GenericDAO sharedGenericDAO]find:[Restaurant class] withParameters:nil completionHandler:^(NSArray* array){
        restaurants = array;
        [restaurants retain];
        [self performSelectorOnMainThread:@selector(showNearestRestaurants) withObject:nil waitUntilDone:NO]; 
    }];
}
-(void)onSkipButtonClicked:(id) sender
{
    if(self.appCallback!=nil)
    {
        [appCallback loadRestaurantList];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNearestRestaurants
{
    NSMutableArray * insertion =[[NSMutableArray alloc] init];
    for (int i=0; i<[restaurants count]; i++) {
        [insertion addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [tableView beginUpdates];
    if ([tableView numberOfRowsInSection:0] >0) {
        NSMutableArray *arr =[[NSMutableArray alloc] init];
        for (int i=0; i<[tableView numberOfRowsInSection:0]; i++) {
            [arr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        [tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    }
    
    [tableView insertRowsAtIndexPaths:insertion withRowAnimation:UITableViewRowAnimationRight];
    [tableView endUpdates];
    
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    panel.alpha = 0.9f;
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [restaurants count];
}
- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [table dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    cell.textLabel.textColor =[UIColor whiteColor];
    cell.textLabel.text = ((Restaurant *)[restaurants objectAtIndex:indexPath.row]).name ;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantShowCtrl * showRest =[[RestaurantShowCtrl alloc] init];
    showRest.appCallback = self.appCallback;
    showRest.restaurant = ((Restaurant *)[restaurants objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:showRest animated:YES];
}
@end
