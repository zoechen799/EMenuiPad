//
//  AppDelegate.h
//  EMenu
//
//  Created by Chen, Jonny on 11/22/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <AVFoundation/AVFoundation.h>
#import "SplitViewControllerRotating.h"
#import "MyURLCache.h"
#import "ChooseRestaurantCtrl.h"
#import "RestaurantShowCtrl.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "RestaurantList.h"
#import "OrderViewController.h"
#import "DishDetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate , AppCallbackDelegate,AVAudioPlayerDelegate>
{
    SplitViewControllerRotating *splitController;
    AVAudioPlayer * player;
    MyURLCache * urlCache;
    
    MasterViewController *masterViewController;
    UINavigationController *masterNavigationController;
    DetailViewController *detailViewController;
    UINavigationController *detailNavigationController;
    
    RestaurantList* restlist;
    UINavigationController * rlNavicontroller;
    
    RestaurantShowCtrl * showRest;
    UINavigationController * rsNavicontroller;
    
    OrderViewController *orderList;
    UINavigationController * odNavicontroller;
    DishDetailViewController *dishDetail;
}
@property (strong, nonatomic) UIWindow *window;
@end
