//
//  RestaurantShowController.h
//  EMenu
//
//  Created by Chen, Jonny on 11/24/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "GenericDAO.h"
#import "iCarousel.h"
#import "AppConstants.h"
#import "GradientButton.h"
#import "Restaurant.h"
#import "BaseViewController.h"

@interface RestaurantShowCtrl : BaseViewController<iCarouselDataSource, iCarouselDelegate>
{
    iCarousel *carousel;
    UIPageControl *pagecontrol;
    NSArray * photos;
    NSArray * intros;
    UILabel * label;
    GradientButton * skipBtn;
    UIView * panel;
}
@property(nonatomic,retain) Restaurant * restaurant;
@property(nonatomic,assign)   id <AppCallbackDelegate> appCallback;
@end
