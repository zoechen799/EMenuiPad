//
//  DetailViewController.m
//  dd
//
//  Created by Chen, Jonny on 11/21/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "DetailViewController.h"
#import "AppConstants.h"
#import "Dish.h"
#import "MenuCell.h"


@implementation DetailViewController
@synthesize appCallback;
@synthesize restaurant;
- (void)dealloc
{
    [_masterPopoverController release];
    [dao release];
    dao = nil;
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setRestaurantAndCategory:(NSDictionary *)newDetailItem
{
    if (_restaurantAndCategory != newDetailItem) {
        [_restaurantAndCategory release];
        _restaurantAndCategory = [newDetailItem retain];

        // Update the view.
        [self loadData];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}
- (void)viewWillLayoutSubviews{
    menuCarousel.frame = self.view.frame;
}
-(void)loadData
{
    if(dao == nil)
        dao =[[DishDAO alloc] init];
    [dao find:[Dish class] withParameters:_restaurantAndCategory completionHandler:^(NSArray *dishlist){
        if (dishes == nil) {
            dishes =[[NSMutableArray alloc] initWithArray:dishlist];
            [dishes retain];
        }else{
            [dishes removeAllObjects];
            [dishes addObjectsFromArray:dishlist];
        }
        [self performSelectorOnMainThread:@selector(configureView) withObject:nil waitUntilDone:NO];
    }];
    
    
    //[menuCarousel reloadData];
}
- (void)configureView
{
    //clean old data
    if(menuCarousel !=nil){
        for (int i=0 ; i< menuCarousel.numberOfItems; i++) {
            [menuCarousel removeItemAtIndex:i animated:NO];
        }
    }
    //insert new items
    if(menuCarousel == nil){
        menuCarousel = [[iCarousel alloc] initWithFrame:self.view.frame];
        menuCarousel.type = iCarouselTypeLinear;
        menuCarousel.delegate =self;
        menuCarousel.dataSource =self;
        [self.view addSubview:menuCarousel];
    }
    for (int i=0; i<dishes.count; i++) {
        [menuCarousel insertItemAtIndex:i animated:NO];
    }
    [menuCarousel reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg2.jpg"]];
    UIBarButtonItem *orderBtn =[[[UIBarButtonItem alloc] initWithTitle:@"已点菜品" style:UIBarButtonItemStyleBordered target:self action:@selector(onOrderClicked:)]autorelease];
    self.navigationItem.rightBarButtonItem =orderBtn;
    [self configureView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeWhenDetailClicked:) name:NOTIFICATION_SHOWDETAIL object:nil];
}
-(void)noticeWhenDetailClicked:(NSNotification*)notice
{
    if(self.appCallback!=nil){
        NSMutableDictionary* params = [[NSMutableDictionary alloc]initWithDictionary: notice.userInfo];
        [params setObject:self.restaurant forKey:@"restaurant"];
        [self.appCallback loadDishDetail:params];
    }
        
}
-(void)onOrderClicked:(id)sender
{
   if(appCallback!=nil)
       [appCallback loadOrderList: restaurant];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    int pagecount = ceil( (float)[dishes count] /(float)NUMBERPERMENUPAGE);
    return pagecount;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil || view.tag != index)
    {
        view = [[[UIView alloc] initWithFrame:self.view.frame] autorelease];
        for(int i=index; i<index+NUMBERPERMENUPAGE && i<[dishes count]; i++)
        {
            Dish* dish =  (Dish*)[dishes objectAtIndex:i];
            float _y = 10;
            if(i-index==2 || i-index==3)
                _y=370;
            MenuCell *cell = [[MenuCell alloc] initWithFrame:CGRectMake(10 + ((i-index)%2) * 320, _y, 250, 320)];
            cell.dish = dish;
            cell.imageurl = dish.logourl;
            [view addSubview:cell];
            [cell loadData];
            [cell release];
        }
        view.tag =index;
    }
    return view;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
}
- (void)carouselDidEndScrollingAnimation:(iCarousel *)aCarousel
{
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)aCarousel
{
}

@end
