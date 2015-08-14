//
//  DetailViewController.h
//  dd
//
//  Created by Chen, Jonny on 11/21/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "DishDAO.h"
#import "AppConstants.h"
#import "Restaurant.h"
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate,iCarouselDataSource, iCarouselDelegate>
{
    iCarousel * menuCarousel;
    NSDictionary * _restaurantAndCategory;
    DishDAO * dao;
    NSMutableArray * dishes;
}
- (void)configureView;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property(nonatomic,retain) NSDictionary * restaurantAndCategory;
@property(nonatomic,assign) id <AppCallbackDelegate> appCallback;
@property(nonatomic,retain) Restaurant * restaurant;
@end
